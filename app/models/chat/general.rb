class Chat::General < Chatroom
  has_many :users, inverse_of: :chat_clan, through: :messages
  has_many :admins, inverse_of: :chat_clans, through: :messages

  def to_s
    'General'
  end

  def type_to_s
    'General'
  end
end
