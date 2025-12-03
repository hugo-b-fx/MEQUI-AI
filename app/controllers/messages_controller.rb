class MessagesController < ApplicationController
  before_action :fake_login

  # Fake current_user (temporaire tant qu’on n’a pas remis Devise)
  def fake_login
    @current_user = User.first
  end

  def current_user
    @current_user
  end

  def create
    @chat = current_user.chat

    # 1. Message utilisateur
    user_message = @chat.messages.create!(
      content: params[:message][:content],
      role: "user",
      user: current_user
    )

    # 2. Historique pour le modèle IA
    messages_for_llm = @chat.messages.order(:created_at).map do |m|
      { role: m.role, content: m.content }
    end

    system_prompt = <<~PROMPT
      Tu es MequiA, l'assistant IA ultra-sympa et expert équestre de m’equi.
      Tu aides les cavaliers à trouver le coach parfait en posant des questions intelligentes.
      Utilise des emojis 🐎✨.
    PROMPT

    messages_for_llm.unshift({ role: "system", content: system_prompt })

    # 3. Appel du modèle
    response = RubyLLM.chat(
      model: "gpt-4o-mini",
      messages: messages_for_llm,
      temperature: 0.7
    )

    # 4. Enregistrement message IA
    @chat.messages.create!(
      content: response.dig("choices", 0, "message", "content"),
      role: "assistant"
    )

    # 5. Turbo stream
    respond_to do |format|
      format.turbo_stream
    end
  end
end
