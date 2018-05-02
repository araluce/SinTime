class UserPrivilegesCard < ApplicationRecord
  include CardsHelper

  belongs_to :privileges_card, inverse_of: :user_privileges_cards
  belongs_to :user, inverse_of: :user_privileges_cards

  attr_accessor :user_to_id

  def to_s
    "@#{user.alias} tiene una carta #{privileges_card} #{valid? ? 'válida' : 'no válida'}"
  end

  def valid?
    card_is_valid?(self)
  end
end
