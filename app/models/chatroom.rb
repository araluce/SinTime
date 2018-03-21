class Chatroom < ApplicationRecord
  has_many :messages, inverse_of: :chatroom, dependent: :destroy

  def is_clan?
    type_to_s == 'Clan'
  end

  def is_individual?
    type_to_s == 'Directo'
  end

  def is_admin?
    type_to_s == 'Admin'
  end

end
