module Padawan
  module Comunidad
    module Rci
      class SalaController < Padawan::Comunidad::Rci::ChatController

        def index
          @districts = District.all
          @users = User.all
          @admins = Admin.all
        end

      end
    end
  end
end