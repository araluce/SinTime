module Chat
  class Admin < Chatroom
    belongs_to :user_1, class_name: '::User', inverse_of: :chat_admins
    belongs_to :admin, class_name: '::Admin' , inverse_of: :chat_admins

    def to_s
      "Conversación entre #{user_1.alias} y #{admin.email}"
    end

    def type_to_s
      'Admin'
    end
  end
end
