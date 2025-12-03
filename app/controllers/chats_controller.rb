class ChatsController < ApplicationController
  # ATTENTION : ONLY FOR DEV
  # Supprimer authenticate_user! pour l'instant
  # before_action :authenticate_user!

  before_action :fake_login_dev

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

  def fake_login_dev
    @current_user = User.first
  end

  def current_user
    @current_user
  end
end
