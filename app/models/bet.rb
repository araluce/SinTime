class Bet < ApplicationRecord
  has_many :options, class_name: 'BetOption', inverse_of: :bet, dependent: :destroy

  validates :bet, presence: true
  validates :options, length: { minimum: 1 }

  def to_s
    bet
  end
end
