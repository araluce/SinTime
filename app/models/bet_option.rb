class BetOption < ApplicationRecord
  belongs_to :bet, class_name: 'Bet', inverse_of: :options

  validates :option, presence: true

  def to_s
    option
  end
end
