class RoomChannel < ApplicationCable::Channel
  def subscribed
    if params[:chat_id].present?
      stream_from("ChatRoom-#{(params[:chat_id])}")
    else
      stream_from 'room_channel'
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # calls when a client broadcasts data
  def speak(data)
    admin_id = data['admin_id']
    user_id = data['user_id']
    chat_id   = data['chat_id']
    message   = data['message']

    raise 'No chat_id!' if chat_id.blank?
    chat = get_chat(chat_id) # A conversation is a room
    raise 'No chat found!' unless chat

    user = get_user(user_id)
    admin = get_admin(admin_id)
    raise 'No sender found' unless user || admin

    raise 'No message!' if message.blank?

    # saves the message and its data to the DB
    # Note: this does not broadcast to the clients yet!
    Message.create!(
        chatroom: chat,
        user: user,
        admin: admin,
        message: message
    )
  end

  # Helpers

  def get_chat(chat_id)
    Chat.find_by(id: chat_id)
  end

  def get_user(user_id)
    User.find_by(id: user_id)
  end

  def get_admin(admin_id)
    Admin.find_by(id: admin_id)
  end
end
