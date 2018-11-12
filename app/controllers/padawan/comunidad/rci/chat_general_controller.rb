module Padawan
  module Comunidad
    module Rci
      class ChatGeneralController < Padawan::Comunidad::Rci::ChatController

        def show
          @chat = model.first_or_create
          check_point
          @messages = @chat.messages.order(created_at: :asc).last(100)
          @message = Message.new
        end

        def model
          Chat::General
        end

      end
    end
  end
end