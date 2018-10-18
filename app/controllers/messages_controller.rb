class MessagesController < ApplicationController
  protect_from_forgery with: :null_session, only: :get_messages

  def create
    message = Message.new(object_params)
    message.viewed = (message.chatroom.is_admin? || message.chatroom.is_general?) ? true : false
    chat = message.chatroom
    server_broadcast = chat.is_general? ? 'room_channel' : "room_#{chat.id}"

    if message.save
      ActionCable.server.broadcast 'room_channel', message:  render_message(message)
    end
  end

  def get_messages
    @user = User.find_by(id: params['user_id'].to_i)
    @admin = Admin.find_by(id: params['admin_id'].to_i)
    messages_to_ignore = params['ids'].flatten
    @chat = Chatroom.find_by(id: params['chat_id'].to_i)
    mark_message_as_viewed
    last_100_messages = @chat.messages.order(created_at: :asc).last(100)
    @messages = []
    last_100_messages.map {|message| @messages << message unless messages_to_ignore.include?(message.id.to_s)}
    render 'get_messages.coffee.js.erb'
  end

  private

  def mark_message_as_viewed
    if @admin.nil?
      @chat.messages.where(viewed: false).where.not(user_id: @user.id).update_all(viewed: true)
    else
      @chat.messages.where(viewed: false).where.not(admin_id: @admin.id).update_all(viewed: true)
    end
  end

  def set_chat
    @chat = @message.chatroom
  end

  def render_message(message)
    render(partial: 'new_message', locals: { message: message })
  end

  def user_model
    User
  end

  def object_params
    params.require(:message).permit(
        :chatroom_id,
        :message
    ).merge(
        user: current_user,
        admin: current_admin
    )
  end

  def chat_messages_params
    params.permit(
              :ids,
              :chat_id
    )
  end

end