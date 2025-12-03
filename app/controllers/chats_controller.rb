class ChatsController < ApplicationController
  before_action :ensure_user

  def show
    @chat = current_user.chat || current_user.create_chat!

    if @chat.messages.none?
      @chat.messages.create!(
        content: @chat.welcome_message,
        role: "assistant"
      )
    end

    @message  = Message.new
    @messages = @chat.messages.order(:created_at).last(15)
  end

  private

  def ensure_user
    return if current_user.present?

    temp_user = User.find_by(email: "dev@example.com")

    unless temp_user
      temp_user = User.create!(
        email: "dev@example.com",
        password: "password123",
        name: "Dev User",
        role: :rider
      )
    end

    sign_in(temp_user)
  end
end
