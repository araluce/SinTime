class MineClue < ApplicationRecord
  belongs_to :mine, inverse_of: :clues
  validates :clue, presence: true

  def to_s
    clue
  end
end
