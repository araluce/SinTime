class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    payload = {
        chatroom_id: message.chatroom_id,
        message: message.message,
        user: message.user,
        admin: message.admin
    }
    ActionCable.server.broadcast(build_room_id(message.chatroom_id), payload)
  end

  def build_room_id(id)
    "ChatRoom-#{id}"
  end
end
