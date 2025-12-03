class ChatsController < ApplicationController
  before_action :load_or_create_user

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

  def load_or_create_user
    return if current_user.present?

    temp_user = User.find_or_create_by!(email: "dev@example.com") do |u|
      u.password = "password123"
      u.name     = "Dev User"
      u.role     = :rider
    end

    sign_in(:user, temp_user)
  end
end
