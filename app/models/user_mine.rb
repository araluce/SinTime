class UserMine < ApplicationRecord
  belongs_to :user, inverse_of: :user_mines
  belongs_to :mine, inverse_of: :user_mines
end
