class ChatsController < ApplicationController
  before_action :authenticate_user!

  def show
    @chat = current_user.chat || current_user.create_chat!
    @message = Message.new # pour le formulaire
  end
end
