class MessagesController < ApplicationController
  protect_from_forgery with: :null_session, only: :get_messages

  def create
    @message = Message.new(object_params)
    @message.user = current_user
    @message.admin = current_admin

    if @message.save
      # if current_user
      #   ActionCable.server.broadcast 'messages', message: @message.message, user: @message.user.alias
      # else
      #   ActionCable.server.broadcast 'messages', message: @message.message, user: 'Admin'
      # end
      # head :ok
    else
    end

    respond_to do |format|
      format.js{ render 'create.coffee.js.erb', locals: { message: @message } }
    end

  end

  def get_messages
    @user = User.find_by(id: params['user_id'].to_i)
    @admin = Admin.find_by(id: params['admin_id'].to_i)
    messages_to_ignore = params['ids'].flatten
    chat = Chatroom.find_by(id: params['chat_id'])
    chat.messages.where(viewed: false).where.not(user: @user, admin: @admin).update_all(viewed: true)
    last_100_messages = chat.messages.order(created_at: :asc).last(100)
    @messages = []
    last_100_messages.map {|message| @messages << message unless messages_to_ignore.include?(message.id.to_s)}
    render 'get_messages.coffee.js.erb'
  end

  private

  def user_model
    User
  end

  def object_params
    params.require(:message).permit(
        :chatroom_id,
        :message
    )
  end

  def chat_messages_params
    params.permit(
              :ids,
              :chat_id
    )
  end

end