class ChatsController < ApplicationController
  before_action :authenticate_user!

  def show
    @chat = current_user.chat || create_chat_with_welcome
    @message = Message.new
    @messages = @chat.messages.order(:created_at).last(15)
  end

  private

  def create_chat_with_welcome
    chat = current_user.create_chat!
    welcome = chat.welcome_message
    chat.messages.create!(content: welcome, role: "assistant")
    chat
  end
end
