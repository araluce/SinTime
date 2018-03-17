module Manager
  class ChatAdminController < Manager::ManagersController
    layout 'chat'

    def show
      @chat = model.find_by(admin: current_admin.id, user_1_id: params[:id].to_i)
      @chat = model.create(admin_id: current_admin.id, user_1_id: params[:id].to_i) if @chat.nil?
      @messages = @chat.messages.order(created_at: :asc).last(100)
      @message = Message.new
    end

    def model
      Chat::Admin
    end

  end
end