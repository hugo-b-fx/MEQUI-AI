class Chat < ApplicationRecord
  belongs_to :user

  has_many :messages, dependent: :destroy

  # Un seul chat IA par utilisateur → évite les doublons
  validates :user_id, uniqueness: true

  # Premier message d'accueil automatique et ultra-personnalisé
  def welcome_message
    <<~WELCOME.strip
      Salut #{user.name.split.first} ! 🐎✨
      Je suis MequiA, ton assistant perso pour trouver le coach parfait.

      Ton profil en bref :
      • Niveau : #{user.level || "non renseigné"}
      • Localisation : #{user.location || "non renseignée"}
      • Objectif : #{user.objective || "non renseigné"}
      • Cheval : #{user.horses.first&.name || "non indiqué"} (#{user.horses.first&.breed || ""})

      Dis-moi ce que tu cherches précisément aujourd’hui (discipline, budget, feeling avec le coach, etc.) et je te trouve les 3 meilleurs matchs tout de suite !
      Ou pose-moi n’importe quelle question, je suis là pour toi 😊
    WELCOME
  end
end
