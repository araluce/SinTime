class Chatroom < ApplicationRecord
  has_many :messages, inverse_of: :chatroom, dependent: :destroy
end
