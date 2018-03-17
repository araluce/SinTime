module Padawan
  module Comunidad
    module Rci
      class ChatUserController < Padawan::Comunidad::RciController
        layout 'chat'

        def show
          @chat = model.find_by(user_1_id: current_user.id, user_2_id: params[:id])
          @chat = model.find_by(user_1_id: params[:id], user_2_id: current_user.id) if @chat.nil?
          @chat = model.create(user_1_id: current_user.id, user_2_id: params[:id]) if @chat.nil?
          @messages = @chat.messages.order(created_at: :asc).last(100)
          @message = Message.new
        end

        def model
          Chat::Individual
        end

      end
    end
  end
end