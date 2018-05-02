class UserClue < ApplicationRecord
  belongs_to :user, inverse_of: :user_clues
  belongs_to :clue, class_name: 'MineClue', inverse_of: :user_clues
end
