class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = current_user.chat

    # 1. Message de l'utilisateur
    user_message = @chat.messages.create!(content: params[:message][:content], role: "user", user: current_user)

    # 2. On construit le contexte complet (tous les messages précédents + system prompt)
    messages_for_llm = @chat.messages.order(:created_at).map do |m|
      { role: m.role, content: m.content }
    end

    # System prompt personnalisé MequiBotIA
    system_prompt = <<~PROMPT
      Tu es MequiA, l'assistant IA ultra-sympa et expert équestre de m’equi.
      Tu aides les cavaliers à trouver le coach parfait en posant des questions intelligentes et en proposant des matchs personnalisés.
      Tu es chaleureux, tu tutoies, tu utilises des emojis 🐎✨.
      Tu connais parfaitement le profil de l'utilisateur :
      - Nom : #{current_user.name}
      - Niveau : #{current_user.level || "non renseigné"}
      - Localisation : #{current_user.location}
      - Objectif : #{current_user.objective}
      - Cheval : #{current_user.horses.first&.name || "non renseigné"} (#{current_user.horses.first&.breed || ""})

      Pose des questions précises pour affiner le matching, et quand tu as assez d’infos, propose les 3 meilleurs coaches avec explication.
      Réponds toujours en français, sois concis et fun.
    PROMPT

    messages_for_llm.unshift({ role: "system", content: system_prompt })

    # 3. Appel ruby_llm
    response = RubyLLM.chat(
      model: "gpt-4o-mini",
      messages: messages_for_llm,
      temperature: 0.7
    )

    # 4. Message de l'IA
    assistant_message = @chat.messages.create!(content: response.dig("choices", 0, "message", "content"), role: "assistant")

    # 5. Turbo Stream : on append les deux messages sans reload
    respond_to do |format|
      format.turbo_stream
    end
  end
end
