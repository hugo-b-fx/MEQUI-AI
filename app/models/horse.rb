class Horse < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :breed, presence: true
end
