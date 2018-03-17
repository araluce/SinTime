module Padawan
  module Comunidad
    module Rci
      class ChatAdminController < Padawan::Comunidad::RciController
        layout 'chat'

        def show
          @chat = model.find_by(user_1_id: current_user.id, admin_id: params[:id])
          @chat = model.create(user_1_id: current_user.id, admin_id: params[:id]) if @chat.nil?
          @messages = @chat.messages.order(created_at: :asc).last(100)
          @message = Message.new
        end

        def model
          Chat::Admin
        end

      end
    end
  end
end