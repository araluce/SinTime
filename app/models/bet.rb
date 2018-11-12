class Bet < ApplicationRecord
  has_many :options, class_name: 'BetOption', inverse_of: :bet, dependent: :destroy
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true

  scope :opens, -> {where(open: true)}
  scope :actives, -> {where(active: true)}

  validates :bet, presence: true
  validates :options, length: { minimum: 1 }

  def to_s
    bet
  end
end
