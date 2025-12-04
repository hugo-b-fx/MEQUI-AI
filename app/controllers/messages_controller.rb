class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = current_user.chat || current_user.create_chat!

    content = params.dig(:message, :content)&.strip
    return head :unprocessable_entity if content.blank?

    user_message = @chat.messages.create!(
      content: content,
      role: "user",
      #user: current_user
    )

    messages_for_llm = @chat.messages.order(:created_at).last(10)

    system_prompt = <<~PROMPT
      Tu es MequiBotIA, l'assistant IA expert équestre de m’equi 🐎✨.
      Tu es chaleureux, tu tutoies, tu utilises des emojis.
      Pose des questions intelligentes pour affiner le matching coach.
      Réponds toujours en français.
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
    rescue => e
      Rails.logger.error "RubyLLM error: #{e.message}"
      ai_content = "Oups 😅 Je n'ai pas compris. Peux-tu reformuler ?"
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
