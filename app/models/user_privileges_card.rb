class UserPrivilegesCard < ApplicationRecord
  belongs_to :privileges_card, inverse_of: :user_privileges_cards
  belongs_to :user, inverse_of: :user_privileges_cards
end
