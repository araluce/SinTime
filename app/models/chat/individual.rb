class Chat::Individual < Chatroom
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'

  def to_s
    "Conversación entre #{user_1.alias} y #{user_2.alias}"
  end

  def type_to_s
    'Directo'
  end

  class << self
    def messages_not_read(cur_user_id, receiver_user_id)
      where(user_1_id: cur_user_id, user_2_id: receiver_user_id).or(where(user_2_id: cur_user_id, user_1_id: receiver_user_id)).joins(:messages).where('user_id != ? AND viewed=?', cur_user_id, false)
    end

    def get_messages(cur_user_id, receiver_user_id)
      where(user_1_id: cur_user_id, user_2_id: receiver_user_id).or(where(user_2_id: cur_user_id, user_1_id: receiver_user_id)).first.try(:messages)
    end
  end
end
