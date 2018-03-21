class Chatroom < ApplicationRecord
  has_many :messages, inverse_of: :chatroom, dependent: :destroy
  has_many :chat_check_points, class_name: 'Chat::CheckPoint', inverse_of: :chatroom

  def is_clan?
    type_to_s == 'Clan'
  end

  def is_individual?
    type_to_s == 'Directo'
  end

  def is_admin?
    type_to_s == 'Admin'
  end

  def is_general?
    type_to_s == 'General'
  end

end
