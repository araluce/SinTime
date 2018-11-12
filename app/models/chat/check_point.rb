class Chat::CheckPoint < ApplicationRecord
  belongs_to :chatroom, inverse_of: :chat_check_points
  belongs_to :user, inverse_of: :chat_check_points, optional: true
  belongs_to :admin, inverse_of: :chat_check_points, optional: true
end
