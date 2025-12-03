class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = current_user.chat
    user_message = @chat.messages.create!(message_params.merge(role: "user", user: current_user))

    messages_for_llm = @chat.messages.order(:created_at).map { |m| { role: m.role, content: m.content } }

    system_prompt = <<~PROMPT
      Tu es MequiBotIA, l'assistant IA expert équestre de m’equi 🐎✨
      Tu es chaleureux, tu tutoies, tu utilises des emojis.
      Tu connais le profil de l'utilisateur :
      • Nom : #{current_user.name}
      • Niveau : #{current_user.level || "non renseigné"}
      • Localisation : #{current_user.location}
      • Objectif : #{current_user.objective}
      • Cheval : #{current_user.horses.first&.name || "non indiqué"} (#{current_user.horses.first&.breed || ""})

      Pose des questions intelligentes pour affiner le matching coach, puis propose les 3 meilleurs avec explication personnalisée.
      Réponds toujours en français, sois fun et concis.
    PROMPT

    messages_for_llm.unshift({ role: "system", content: system_prompt })

    response = RubyLLM.chat(
      model: "gpt-4o-mini",
      messages: messages_for_llm,
      temperature: 0.7
    )

    @chat.messages.create!(content: response.dig("choices", 0, "message", "content"), role: "assistant")

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
