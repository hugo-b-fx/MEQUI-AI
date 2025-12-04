class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = current_user.chat || current_user.create_chat!

    content = params.dig(:message, :content)&.strip
    return head :unprocessable_entity if content.blank?

    user_message = @chat.messages.create!(
      content: content,
      role: "user",
      user: current_user
    )

    # Historique limité aux 15 derniers messages
    messages_for_llm = @chat.messages.order(:created_at).last(15).map do |m|
      { role: m.role, content: m.content }
    end

    system_prompt = <<~PROMPT
      Tu es MequiBotIA, l'assistant IA expert équestre de m’equi 🐎✨
      Tu es chaleureux, tu tutoies, tu utilises des emojis.
      Tu connais le profil de l'utilisateur :
      • Nom : #{current_user.name}
      • Niveau : #{current_user.level || "non renseigné"}
      • Localisation : #{current_user.location || "non renseignée"}
      • Objectif : #{current_user.objective || "non renseigné"}
      • Cheval : #{current_user.horses.first&.name || "non indiqué"} (#{current_user.horses.first&.breed || ""})

      Pose des questions intelligentes pour affiner le matching coach.
      Quand tu as assez d’infos, propose les 3 meilleurs coaches avec explication personnalisée.
      Réponds toujours en français, sois fun, concis et motivant.
    PROMPT

    messages_for_llm.unshift({ role: "system", content: system_prompt })

    begin
      response = RubyLLM.chat(
        model: "gpt-4o-mini",
        messages: messages_for_llm,
        temperature: 0.7
      )

      ai_content = response.dig("choices", 0, "message", "content")
      ai_content ||= "Je n’ai pas bien compris, peux-tu reformuler ? 😅"

    rescue StandardError => e
      Rails.logger.error "Erreur RubyLLM : #{e.message}"
      ai_content = "Oups, je suis un peu distrait aujourd’hui 😅 Peux-tu répéter ta question ?"
    end

    @chat.messages.create!(
      content: ai_content,
      role: "assistant"
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
