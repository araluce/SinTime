class Chat::Clan < Chatroom
  belongs_to :district
  has_many :users, inverse_of: :chat_clan, through: :messages
  has_many :admins, inverse_of: :chat_clans, through: :messages

  def to_s
    district.to_s
  end

  def type_to_s
    'Clan'
  end
end
