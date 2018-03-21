module Padawan
  module Comunidad
    module Rci
      class ChatController < Padawan::Comunidad::RciController
        layout 'chat'

        def check_point
          if current_user
            @chat.chat_check_points.find_or_create_by(user: current_user).update_columns(updated_at: DateTime.now)
          elsif current_admin
            @chat.chat_check_points.find_or_create_by(admin: current_admin).update_columns(updated_at: DateTime.now)
          end
        end

      end
    end
  end
end