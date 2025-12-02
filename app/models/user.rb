class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :horses
  has_many :chats

  enum role: { rider: 0, coach: 1 }
end
