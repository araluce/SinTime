class Chat::Admin < Chatroom
  belongs_to :user_1, inverse_of: :chat_admins
  belongs_to :admin, inverse_of: :chat_admins

  def to_s
    "Conversación entre #{user_1.alias} y #{user_2.alias}"
  end

  def type_to_s
    'Admin'
  end
end
