class ChatsController < ApplicationController

  before_action :fake_login

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

  # --------------------------
  # TEMPORARY DEV LOGIN (Heroku included)
  # --------------------------
  def fake_login
    @current_user = User.first
  end

  def current_user
    @current_user
  end
end
