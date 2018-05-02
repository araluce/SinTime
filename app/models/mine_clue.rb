class MineClue < ApplicationRecord
  belongs_to :mine, inverse_of: :clues

  has_many :user_clues, class_name: 'UserClue', inverse_of: :clue, dependent: :destroy
  has_many :users, through: :user_clues, inverse_of: :clues

  validates :clue, presence: true

  def to_s
    clue
  end
end
