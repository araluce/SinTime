class Chat::Individual < Chatroom
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'

  def to_s
    "Conversación entre #{user_1.alias} y #{user_2.alias}"
  end

  def type_to_s
    'Directo'
  end
end
