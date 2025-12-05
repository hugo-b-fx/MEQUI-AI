class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = current_user.chat || current_user.create_chat!

    content = params[:content]&.strip
    return head :unprocessable_entity if content.blank?

    @chat.messages.create!(
      content: content,
      role: "user"
    )

    coaches = User.where(role: "coach")
    coaches_context = coaches.map do |c|
      <<~STR
        - Nom: #{c.name}
        Spécialités: #{c.specialities}
        Niveau: #{c.level}
        Bio: #{c.bio}
        Location: #{c.location}
        Prix: #{c.price_per_hour}
      STR
    end.join("\n")

    messages_for_llm = @chat.messages.order(:created_at).last(10)

    system_prompt = <<~PROMPT
      Tu es MequiBotIA, l'assistant IA expert équestre de m’equi 🐎✨.
      Tu es chaleureux, tu tutoies, tu utilises des emojis.
      Pose des questions intelligentes pour affiner le matching coach.
      Réponds toujours en français.
      Voici la liste des coachs disponibles dans la base :
      #{coaches_context}
      Utilise exclusivement cette liste pour faire tes recommandations.
      Si un coach ne correspond pas, explique pourquoi.
      N'invente jamais de coachs.
      Pose des questions pertinentes pour affiner le choix.
    PROMPT

    conversation_text = messages_for_llm.map do |m|
      prefix = m.role == "assistant" ? "Assistant" : "User"
      "#{prefix}: #{m.content}"
    end.join("\n")

    final_prompt = "#{system_prompt}\n\n#{conversation_text}\nAssistant:"

    begin
      chat = RubyLLM.chat
      response = chat.ask(final_prompt)
      ai_content = response.content
    rescue
      ai_content = "Oups 😅 Je n'ai pas compris. Peux-tu reformuler ?"
    end

    @chat.messages.create!(
      content: ai_content,
      role: "assistant"
    )

    @message = @chat.messages.last

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path(@chat) }
    end
  end
end
