puts "Nettoyage de la base..."
Horse.destroy_all
Profile.destroy_all
User.destroy_all

puts "Création de 10 cavaliers + 10 coaches..."

# ======================
# 10 CAVALIERS
# ======================

cavalier1 = User.create!(email: "camille.dubois@gmail.com", password: "123456", first_name: "Camille", last_name: "Dubois")
Profile.create!(
  user: cavalier1,
  kind: "rider",
  level: "Galop 7",
  disciplines: ["dressage", "saut_obstacle"],
  location: "Paris",
  budget_cents: 150_000,
  goals: "Préparer des concours nationaux en dressage, cheval expérimenté et sensible",
  experience_years: 15
)
Horse.create!(profile: cavalier1.profile, name: "Quartz", age: 12, level: "Pro 1", breed: "Selle Français")

cavalier2 = User.create!(email: "leo.martin@gmail.com", password: "123456", first_name: "Léo", last_name: "Martin")
Profile.create!(
  user: cavalier2,
  kind: "rider",
  level: "Galop 5",
  disciplines: ["saut_obstacle", "hunter"],
  location: "Lyon",
  budget_cents: 90_000,
  goals: "Progresser à l’obstacle, coach patient et motivant",
  experience_years: 6
)
Horse.create!(profile: cavalier2.profile, name: "Rocket", age: 9, level: "Galop 5", breed: "Holsteiner")

cavalier3 = User.create!(email: "emma.durand@gmail.com", password: "123456", first_name: "Emma", last_name: "Durand")
Profile.create!(
  user: cavalier3,
  kind: "rider",
  level: "Galop 6",
  disciplines: ["concours_complet"],
  location: "Bordeaux",
  budget_cents: 120_000,
  goals: "Améliorer le cross, cheval courageux et endurant",
  experience_years: 10
)
Horse.create!(profile: cavalier3.profile, name: "Tempête", age: 14, level: "Pro Élites", breed: "Anglo-Arabe")

cavalier4 = User.create!(email: "lucas.moreau@gmail.com", password: "123456", first_name: "Lucas", last_name: "Moreau")
Profile.create!(
  user: cavalier4,
  kind: "rider",
  level: "Galop 4",
  disciplines: ["western", "equifun"],
  location: "Marseille",
  budget_cents: 70_000,
  goals: "Découvrir le western, ambiance détendue et fun",
  experience_years: 3
)

Horse.create!(profile: cavalier4.profile, name: "Whiskey", age: 10, level: "Galop 4", breed: "Quarter Horse")

cavalier5 = User.create!(email: "chloe.rousseau@gmail.com", password: "123456", first_name: "Chloé", last_name: "Rousseau")
Profile.create!(
  user: cavalier5,
  kind: "rider",
  level: "Galop 7",
  disciplines: ["dressage"],
  location: "Toulouse",
  budget_cents: 180_000,
  goals: "Travailler la reprise Grand Prix, cheval très scolaire",
  experience_years: 18
)
Horse.create!(profile: cavalier5.profile, name: "Valentino", age: 13, level: "Grand Prix", breed: "Lusitanien")

cavalier6 = User.create!(email: "theo.girard@gmail.com", password: "123456", first_name: "Théo", last_name: "Girard")
Profile.create!(
  user: cavalier6,
  kind: "rider",
  level: "Galop 3",
  disciplines: ["saut_obstacle", "equifun"],
  location: "Nantes",
  budget_cents: 60_000,
  goals: "Prendre confiance aux barres, coach très pédagogue",
  experience_years: 4
)
Horse.create!(profile: cavalier6.profile, name: "Fuego", age: 8, level: "Galop 3", breed: "Connemara")

cavalier7 = User.create!(email: "manon.petit@gmail.com", password: "123456", first_name: "Manon", last_name: "Petit")
Profile.create!(
  user: cavalier7,
  kind: "rider",
  level: "Galop 6",
  disciplines: ["hunter", "dressage"],
  location: "Lille",
  budget_cents: 100_000,
  goals: "Style et régularité en hunter",
  experience_years: 9
)
Horse.create!(profile: cavalier7.profile, name: "Harmony", age: 11, level: "Galop 6", breed: "KWPN")

cavalier8 = User.create!(email: "hugo.blanc@gmail.com", password: "123456", first_name: "Hugo", last_name: "Blanc")
Profile.create!(
  user: cavalier8,
  kind: "rider",
  level: "Galop 5",
  disciplines: ["concours_complet", "saut_obstacle"],
  location: "Strasbourg",
  budget_cents: 85_000,
  goals: "Progresser en complet, cheval polyvalent",
  experience_years: 7
)
Horse.create!(profile: cavalier8.profile, name: "Storm", age: 10, level: "Amateur 1", breed: "Irish Sport Horse")

cavalier9 = User.create!(email: "julie.laurent@gmail.com", password: "123456", first_name: "Julie", last_name: "Laurent")
Profile.create!(
  user: cavalier9,
  kind: "rider",
  level: "Galop 7",
  disciplines: ["dressage"],
  location: "Nice",
  budget_cents: 200_000,
  goals: "Préparer Saint-Georges / Inter I",
  experience_years: 20
)
Horse.create!(profile: cavalier9.profile, name: "Don Juan", age: 15, level: "Grand Prix", breed: "Hanoverien")

cavalier10 = User.create!(email: "antoine.robert@gmail.com", password: "123456", first_name: "Antoine", last_name: "Robert")
Profile.create!(
  user: cavalier10,
  kind: "rider",
  level: "Galop 4",
  disciplines: ["equifun", "saut_obstacle"],
  location: "Rennes",
  budget_cents: 75_000,
  goals: "S’amuser, progresser sans pression",
  experience_years: 5
)
Horse.create!(profile: cavalier10.profile, name: "Pépito", age: 12, level: "Galop 4", breed: "Poney Français de Selle")

# ======================
# 10 COACHS
# ======================

coach1 = User.create!(email: "sophie.leroy@gmail.com", password: "123456", first_name: "Sophie", last_name: "Leroy")
Profile.create!(
  user: coach1,
  kind: "coach",
  level: "DEJEPS",
  disciplines: ["dressage", "saut_obstacle"],
  location: "Paris",
  teaching_style: "Pédagogie positive, valorisation du couple, travail en douceur",
  price_range: "90-140€/h",
  experience_years: 20,
  availability: ["lundi", "mercredi", "vendredi", "samedi"]
)

coach2 = User.create!(email: "thomas.bernard@gmail.com", password: "123456", first_name: "Thomas", last_name: "Bernard")
Profile.create!(
  user: coach2,
  kind: "coach",
  level: "BPJEPS",
  disciplines: ["saut_obstacle", "hunter"],
  location: "Lyon",
  teaching_style: "Technique, résultats rapides, ambiance pro",
  price_range: "70-110€/h",
  experience_years: 12,
  availability: ["mardi", "jeudi", "samedi"]
)

coach3 = User.create!(email: "marine.dupont@gmail.com", password: "123456", first_name: "Marine", last_name: "Dupont")
Profile.create!(
  user: coach3,
  kind: "coach",
  level: "BEES 2",
  disciplines: ["concours_complet"],
  location: "Bordeaux",
  teaching_style: "Spécialiste cross, sécurité, préparation mentale",
  price_range: "80-120€/h",
  experience_years: 18,
  availability: ["lundi", "jeudi", "vendredi"]
)

coach4 = User.create!(email: "julien.roche@gmail.com", password: "123456", first_name: "Julien", last_name: "Roche")
Profile.create!(
  user: coach4,
  kind: "coach",
  level: "DEJEPS",
  disciplines: ["western", "reining"],
  location: "Marseille",
  teaching_style: "Américain décontracté, précision et légèreté",
  price_range: "75-100€/h",
  experience_years: 15,
  availability: ["mercredi", "vendredi", "week-end"]
)

coach5 = User.create!(email: "aude.martin@gmail.com", password: "123456", first_name: "Aude", last_name: "Martin")
Profile.create!(
  user: coach5,
  kind: "coach",
  level: "BPJEPS",
  disciplines: ["dressage", "equitation éthologique"],
  location: "Toulouse",
  teaching_style: "Éthologique, connexion cheval/cavalier, sans force",
  price_range: "65-95€/h",
  experience_years: 10,
  availability: ["lundi", "mardi", "jeudi"]
)

coach6 = User.create!(email: "nicolas.garcia@gmail.com", password: "123456", first_name: "Nicolas", last_name: "Garcia")
Profile.create!(
  user: coach6,
  kind: "coach",
  level: "DEJEPS",
  disciplines: ["saut_obstacle", "hunter"],
  location: "Nantes",
  teaching_style: "Technique pointue, préparation concours, exigence bienveillante",
  price_range: "85-130€/h",
  experience_years: 22,
  availability: ["mardi", "mercredi", "samedi"]
)

coach7 = User.create!(email: "celine.robert@gmail.com", password: "123456", first_name: "Céline", last_name: "Robert")
Profile.create!(
  user: coach7,
  kind: "coach",
  level: "BEES 2",
  disciplines: ["hunter", "equifun"],
  location: "Lille",
  teaching_style: "Fun, ludique, progression rapide pour enfants & adultes",
  price_range: "60-90€/h",
  experience_years: 14,
  availability: ["lundi", "jeudi", "samedi"]
)

coach8 = User.create!(email: "vincent.leroux@gmail.com", password: "123456", first_name: "Vincent", last_name: "Leroux")
Profile.create!(
  user: coach8,
  kind: "coach",
  level: "BPJEPS",
  disciplines: ["concours_complet", "saut_obstacle"],
  location: "Strasbourg",
  teaching_style: "Cross & obstacle, mental d’acier, sécurité avant tout",
  price_range: "80-115€/h",
  experience_years: 16,
  availability: ["mercredi", "vendredi", "dimanche"]
)

coach9 = User.create!(email: "elodie.fournier@gmail.com", password: "123456", first_name: "Élodie", last_name: "Fournier")
Profile.create!(
  user: coach9,
  kind: "coach",
  level: "DEJEPS Dressage",
  disciplines: ["dressage"],
  location: "Nice",
  teaching_style: "Classique français, précision, élégance, reprises parfaites",
  price_range: "100-150€/h",
  experience_years: 25,
  availability: ["lundi", "mardi", "vendredi"]
)

coach10 = User.create!(email: "remi.david@gmail.com", password: "123456", first_name: "Rémi", last_name: "David")
Profile.create!(
  user: coach10,
  kind: "coach",
  level: "BPJEPS",
  disciplines: ["equifun", "western", "balades"],
  location: "Rennes",
  teaching_style: "Détente, balades, plaisir avant tout",
  price_range: "55-85€/h",
  experience_years: 11,
  availability: ["mercredi", "samedi", "dimanche"]
)

puts "Seed terminée ! #{User.count} utilisateurs créés (10 cavaliers + 10 coaches) avec profils & chevaux."
puts "Tu peux maintenant tester le matching IA en toute tranquillité !"

# Lancement : rails db:seed
