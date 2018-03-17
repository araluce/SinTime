module Padawan
  module Comunidad
    module Rci
      class SalaController < Padawan::Comunidad::RciController
        layout 'chat'

        def index
          @districts = District.all
          @users = User.all
          @admins = Admin.all
        end

      end
    end
  end
end