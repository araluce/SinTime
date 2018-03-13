class Chatroom < ApplicationRecord
  has_many :messages, inverse_of: :chat_room, dependent: :destroy
end
