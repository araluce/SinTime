class UserMine < ApplicationRecord
  belongs_to :user, inverse_of: :user_mines
  belongs_to :mine, inverse_of: :user_mines

  validate :check_if_available

  def to_s
    "@#{user.alias} ha desactivado la mina - #{created_at.to_formatted_s(:long)}"
  end

  private

  def check_if_available
    errors.add(:mine, 'La mina no está activa') unless mine.available?
  end
end
