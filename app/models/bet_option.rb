class BetOption < ApplicationRecord
  belongs_to :bet, class_name: 'Bet', inverse_of: :options

  has_many :bet_users, class_name: 'BetOptionUser', inverse_of: :bet_option, dependent: :destroy

  scope :right_options, -> { where(right_option: true) }

  validates :option, presence: true

  def to_s
    option
  end
end
