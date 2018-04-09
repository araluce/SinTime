module Padawan
  module Comunidad
    module Rci
      class ChatUserController < Padawan::Comunidad::Rci::ChatController

        def show
          @chat = model.find_by(user_1_id: current_user.id, user_2_id: params[:id])
          @chat = model.find_by(user_1_id: params[:id], user_2_id: current_user.id) if @chat.nil?
          @chat = model.create(user_1_id: current_user.id, user_2_id: params[:id]) if @chat.nil?
          @messages = @chat.messages.order(created_at: :asc).last(100)
          mark_message_as_viewed
          @message = Message.new
        end

        def model
          Chat::Individual
        end

        private

        def mark_message_as_viewed
          @chat.messages.where(viewed: false).where.not(user_id: current_user.id).update_all(viewed: true)
        end

      end
    end
  end
end