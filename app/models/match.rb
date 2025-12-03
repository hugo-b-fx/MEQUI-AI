class Match < ApplicationRecord
  belongs_to :rider, class_name: "User"
  belongs_to :coach, class_name: "User"

  enum status: { pending: 0, accepted: 1, rejected: 2 }
end
