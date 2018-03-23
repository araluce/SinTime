class PrivilegesCard < ApplicationRecord

  has_attached_file :card
  validates_attachment_content_type :card, content_type: /\Aimage\/.*\z/

  has_many :user_privileges_cards, inverse_of: :privileges_card
  has_many :users, through: :user_privileges_cards, inverse_of: :privileges_cards

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  validates :title, :description, :identifier, presence: true
  validates :xp_cost, numericality: {greater_than_or_equal_to: 0, only_integer: true}

  def to_s
    title
  end
end
