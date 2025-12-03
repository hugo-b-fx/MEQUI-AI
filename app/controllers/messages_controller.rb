class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = current_user.chat || current_user.create_chat!

    content = params.dig(:message, :content)&.strip

    if content.blank?
      return head :unprocessable_entity
    end

    user_message = @chat.messages.create!(
      content: content,
      role: "user",
      user: current_user
    )

    messages_for_llm = @chat.messages.order(:created_at).last(15).map do |m|
      { role: m.role, content: m.content }
    end

    system_prompt = <<~PROMPT
      Tu es MequiA, l'assistant IA ultra-sympa et expert équestre de m’equi.
      Tu aides les cavaliers à trouver le coach parfait en posant des questions intelligentes
      et en proposant des matchs personnalisés.
      Tu es chaleureux, tu tutoies, tu utilises des emojis 🐎✨.

      Tu connais le profil de l'utilisateur :
      - Nom : #{current_user.name}
      - Niveau : #{current_user.level || "non renseigné"}
      - Localisation : #{current_user.location || "non renseignée"}
      - Objectif : #{current_user.objective || "non renseigné"}
      - Cheval : #{current_user.horses.first&.name || "non renseigné"} (#{current_user.horses.first&.breed || ""})

      Pose des questions précises pour affiner le matching et,
      quand tu as assez d’infos, propose les 3 meilleurs coaches avec explication.
      Réponds toujours en français, de façon concise, claire et fun.
    PROMPT

    messages_for_llm.unshift({ role: "system", content: system_prompt })

    begin
      response = RubyLLM.chat(
        model: "gpt-4o-mini",
        messages: messages_for_llm,
        temperature: 0.7
      )

      ai_content = response.dig("choices", 0, "message", "content")
      ai_content ||= "Je n’ai pas bien compris la réponse du modèle, peux-tu reformuler ? 😅"
    rescue StandardError => e
      ai_content = "Oups… une petite erreur technique est survenue 😅 Peux-tu répéter ta question ?"
    end

    assistant_message = @chat.messages.create!(
      content: ai_content,
      role: "assistant"
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path }
    end
  end
end
