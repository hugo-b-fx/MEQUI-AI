# User (avec role string "rider" ou "coach") + Horse (belongs_to user)

puts "Nettoyage de la base..."
Horse.destroy_all
User.destroy_all

puts "Création de 10 cavaliers + 10 coaches + chevaux..."

# ======================
# 10 CAVALIERS (role: "rider")
# ======================

rider1 = User.create!(
  email: "camille.dubois@gmail.com",
  password: "123456",
  name: "Camille Dubois",
  role: "rider",
  level: "Galop 7",
  location: "Paris",
  objective: "Préparer des concours nationaux en dressage, cheval expérimenté et sensible",
  bio: "Passionnée depuis 15 ans, je cherche le coach parfait pour passer au niveau supérieur",
  photos: ""
)
Horse.create!(user: rider1, name: "Quartz", age: 12, breed: "Selle Français")

rider2 = User.create!(
  email: "leo.martin@gmail.com",
  password: "123456",
  name: "Léo Martin",
  role: "rider",
  level: "Galop 5",
  location: "Lyon",
  objective: "Progresser à l’obstacle, coach patient et motivant",
  bio: "Reprise depuis 2 ans après une pause, besoin de confiance",
  photos: ""
)
Horse.create!(user: rider2, name: "Rocket", age: 9, breed: "Holsteiner")

rider3 = User.create!(
  email: "emma.durand@gmail.com",
  password: "123456",
  name: "Emma Durand",
  role: "rider",
  level: "Galop 6",
  location: "Bordeaux",
  objective: "Améliorer le cross, cheval courageux et endurant",
  bio: "Completiste passionnée, toujours partante pour l'aventure",
  photos: ""
)
Horse.create!(user: rider3, name: "Tempête", age: 14, breed: "Anglo-Arabe")

rider4 = User.create!(
  email: "lucas.moreau@gmail.com",
  password: "123456",
  name: "Lucas Moreau",
  role: "rider",
  level: "Galop 4",
  location: "Marseille",
  objective: "Découvrir le western, ambiance détendue et fun",
  bio: "Nouveau dans le western, je veux prendre du plaisir avant tout",
  photos: ""
)
Horse.create!(user: rider4, name: "Whiskey", age: 10, breed: "Quarter Horse")

rider5 = User.create!(
  email: "chloe.rousseau@gmail.com",
  password: "123456",
  name: "Chloé Rousseau",
  role: "rider",
  level: "Galop 7",
  location: "Toulouse",
  objective: "Travailler la reprise Grand Prix",
  bio: "Niveau très avancé, perfectionniste et scolaire",
  photos: ""
)
Horse.create!(user: rider5, name: "Valentino", age: 13, breed: "Lusitanien")

rider6 = User.create!(
  email: "theo.girard@gmail.com",
  password: "123456",
  name: "Théo Girard",
  role: "rider",
  level: "Galop 3",
  location: "Nantes",
  objective: "Prendre confiance aux barres",
  bio: "Jeune cavalier timide qui adore les poneys",
  photos: ""
)
Horse.create!(user: rider6, name: "Fuego", age: 8, breed: "Connemara")

rider7 = User.create!(
  email: "manon.petit@gmail.com",
  password: "123456",
  name: "Manon Petit",
  role: "rider",
  level: "Galop 6",
  location: "Lille",
  objective: "Style et régularité en hunter",
  bio: "Amatrice sérieuse, je veux briller en concours",
  photos: ""
)
Horse.create!(user: rider7, name: "Harmony", age: 11, breed: "KWPN")

rider8 = User.create!(
  email: "hugo.blanc@gmail.com",
  password: "123456",
  name: "Hugo Blanc",
  role: "rider",
  level: "Galop 5",
  location: "Strasbourg",
  objective: "Progresser en complet, cheval polyvalent",
  bio: "Motivé et prêt à tout pour progresser",
  photos: ""
)
Horse.create!(user: rider8, name: "Storm", age: 10, breed: "Irish Sport Horse")

rider9 = User.create!(
  email: "julie.laurent@gmail.com",
  password: "123456",
  name: "Julie Laurent",
  role: "rider",
  level: "Galop 7",
  location: "Nice",
  objective: "Préparer Saint-Georges / Inter I",
  bio: "Cavalière confirmée, objectif Grand Prix",
  photos: ""
)
Horse.create!(user: rider9, name: "Don Juan", age: 15, breed: "Hanoverien")

rider10 = User.create!(
  email: "antoine.robert@gmail.com",
  password: "123456",
  name: "Antoine Robert",
  role: "rider",
  level: "Galop 4",
  location: "Rennes",
  objective: "S’amuser, progresser sans pression",
  bio: "Loisir pur plaisir, balades et petits concours",
  photos: ""
)
Horse.create!(user: rider10, name: "Pépito", age: 12, breed: "Poney Français de Selle")

# ======================
# 10 COACHS (role: "coach")
# ======================

coach1 = User.create!(
  email: "sophie.leroy@gmail.com",
  password: "123456",
  name: "Sophie Leroy",
  role: "coach",
  price_per_hour: 100,
  specialities: "dressage,saut_obstacle",
  location: "Paris",
  bio: "20 ans d’expérience, pédagogie positive, valorisation du couple",
  photos: ""
)

coach2 = User.create!(
  email: "thomas.bernard@gmail.com",
  password: "123456",
  name: "Thomas Bernard",
  role: "coach",
  price_per_hour: 90,
  specialities: "saut_obstacle,hunter",
  location: "Lyon",
  bio: "Technique, résultats rapides, ambiance pro",
  photos: ""
)

coach3 = User.create!(
  email: "marine.dupont@gmail.com",
  password: "123456",
  name: "Marine Dupont",
  role: "coach",
  price_per_hour: 95,
  specialities: "concours_complet",
  location: "Bordeaux",
  bio: "Spécialiste cross, sécurité et préparation mentale",
  photos: ""
)

coach4 = User.create!(
  email: "julien.roche@gmail.com",
  password: "123456",
  name: "Julien Roche",
  role: "coach",
  price_per_hour: 85,
  specialities: "western,reining",
  location: "Marseille",
  bio: "Style américain, légèreté et précision",
  photos: ""
)

coach5 = User.create!(
  email: "aude.martin@gmail.com",
  password: "123456",
  name: "Aude Martin",
  role: "coach",
  price_per_hour: 80,
  specialities: "dressage,éthologique",
  location: "Toulouse",
  bio: "Éthologique, connexion sans force",
  photos: ""
)

coach6 = User.create!(
  email: "nicolas.garcia@gmail.com",
  password: "123456",
  name: "Nicolas Garcia",
  role: "coach",
  price_per_hour: 110,
  specialities: "saut_obstacle,hunter",
  location: "Nantes",
  bio: "Exigence bienveillante, préparation concours",
  photos: ""
)

coach7 = User.create!(
  email: "celine.robert@gmail.com",
  password: "123456",
  name: "Céline Robert",
  role: "coach",
  price_per_hour: 75,
  specialities: "hunter,equifun",
  location: "Lille",
  bio: "Fun, ludique, progression rapide pour tous âges",
  photos: ""
)

coach8 = User.create!(
  email: "vincent.leroux@gmail.com",
  password: "123456",
  name: "Vincent Leroux",
  role: "coach",
  price_per_hour: 100,
  specialities: "concours_complet",
  location: "Strasbourg",
  bio: "Mental d’acier, sécurité avant tout",
  photos: ""
)

coach9 = User.create!(
  email: "elodie.fournier@gmail.com",
  password: "123456",
  name: "Élodie Fournier",
  role: "coach",
  price_per_hour: 130,
  specialities: "dressage",
  location: "Nice",
  bio: "Classique français, précision et élégance",
  photos: ""
)

coach10 = User.create!(
  email: "remi.david@gmail.com",
  password: "123456",
  name: "Rémi David",
  role: "coach",
  price_per_hour: 70,
  specialities: "equifun,balades",
  location: "Rennes",
  bio: "Plaisir avant tout, balades et détente",
  photos: ""
)

puts "Seed terminée ! #{User.count} utilisateurs créés (10 cavaliers + 10 coaches) + 10 chevaux."
puts "Tout est prêt pour tester le matching IA !"

# Lancement : rails db:seed
