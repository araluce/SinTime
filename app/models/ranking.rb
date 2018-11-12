class Ranking < ApplicationRecord
  validates :position, presence: true
end
