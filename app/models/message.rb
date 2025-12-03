class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user, optional: true # nil = message de l'IA

  validates :content, presence: true

  enum role: { user: "user", assistant: "assistant" }

  # Turbo Stream broadcast pour append en live
  after_create_commit -> { broadcast_append_to chat, target: "messages", partial: "messages/message", locals: { message: self } }

  def sent_at
    created_at.strftime("%H:%M")
  end

  def from_assistant?
    role == "assistant"
  end
end
