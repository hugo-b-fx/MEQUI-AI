class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :user_id, uniqueness: true

  def welcome_message
    first_name = user.name.to_s.split.first
    horse      = user.horses.first

    <<~WELCOME.strip
      Salut #{first_name.presence || "cavalier"} ! 🐎✨
      Je suis MequiA, ton assistant perso pour trouver le coach parfait.

      Ton profil en bref :
      • Niveau : #{user.level || "non renseigné"}
      • Localisation : #{user.location || "non renseignée"}
      • Objectif : #{user.objective || "non renseigné"}
      • Cheval : #{horse&.name || "non indiqué"} #{"(#{horse&.breed})" if horse&.breed.present?}

      Dis-moi ce que tu cherches précisément aujourd’hui (discipline, budget, feeling avec le coach, etc.)
      et je te trouve les 3 meilleurs matchs tout de suite !
      Ou pose-moi n’importe quelle question, je suis là pour toi 😊
    WELCOME
  end
end
