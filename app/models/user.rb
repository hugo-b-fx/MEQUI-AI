class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :matches_as_rider,
           class_name: "Match",
           foreign_key: "rider_id",
           dependent: :destroy
  has_many :matches_as_coach,
           class_name: "Match",
           foreign_key: "coach_id",
           dependent: :destroy

  has_many :horses, dependent: :destroy
  has_many :chats, dependent: :destroy
  enum role: { rider: 0, coach: 1 }
  validates :name, presence: true
  validates :role, presence: true
  with_options if: :coach? do
    validates :specialities, presence: true
    validates :price_per_hour, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :level, presence: true
  end

  def coach_profile
    return nil unless coach?

    {
      id: id,
      name: name,
      specialities: specialities,
      price_per_hour: price_per_hour,
      level: level,
      objective: objective,
      location: location
    }
  end

  def rider_needs
    return nil unless rider?

    {
      level: level,
      objective: objective,
      discipline: specialities,
      location: location
    }
  end
end
