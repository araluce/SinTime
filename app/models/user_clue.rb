class UserClue < ApplicationRecord
  belongs_to :user, inverse_of: :user_clues
  belongs_to :clue, class_name: 'MineClue', inverse_of: :user_clues

  def to_s
    "@#{user.alias} ha obtuvo la pista '#{clue}'- #{created_at.to_formatted_s(:long)}"
  end
end
