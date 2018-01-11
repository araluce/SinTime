class District < ApplicationRecord
  has_many :users, inverse_of: :district

  validates :name, presence: true
end
