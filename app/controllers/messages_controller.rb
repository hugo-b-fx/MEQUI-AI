class MessagesController < ApplicationController
  before_action :fake_login

  def fake_login
    @current_user = User.first
  end

  def current_user
    @current_user
  end

  def create
    @chat = current_user.chat

    user_message = @chat.messages.create!(
      content: params[:message][:content],
      role: "user",
      user: current_user
    )

    messages_for_llm = @chat.messages.order(:created_at).map do |m|
      { role: m.role, content: m.content }
    end

    system_prompt = <<~PROMPT
      Tu es MequiA, l'assistant IA ultra-sympa et expert équestre de m’equi.
      Tu aides les cavaliers à trouver le coach parfait en posant des questions intelligentes.
      Utilise des emojis 🐎✨.
    PROMPT

    messages_for_llm.unshift({ role: "system", content: system_prompt })

    # =====================================================
    #               APPEL IA AVEC GESTION D’ERREUR
    # =====================================================

    begin
      response = RubyLLM.chat(
        model: "gpt-4o-mini",
        messages: messages_for_llm,
        temperature: 0.7
      )

      Rails.logger.debug "LLM RAW RESPONSE: #{response.inspect}"

      ai_text = response.dig("choices", 0, "message", "content")

      # Si l’IA renvoie un format inattendu ou vide
      if ai_text.blank?
        ai_text = "Oups 😅 Je n’ai pas réussi à générer une réponse. Peux-tu reformuler ?"
      end

    rescue => e
      Rails.logger.error "IA ERROR: #{e.class} - #{e.message}"
      ai_text = "Une erreur s’est produite côté IA 😢 Réessaie dans un instant !"
    end

    @chat.messages.create!(
      content: ai_text,
      role: "assistant"
    )

    respond_to do |format|
      format.turbo_stream
    end
  end
end
