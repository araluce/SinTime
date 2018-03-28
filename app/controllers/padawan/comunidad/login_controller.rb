module Padawan
  module Comunidad
    class LoginController < Padawan::ComunidadController
      layout 'padawan'
      before_action :set_objects

      def model
        UserRuntastic
      end

      def new
        @object = current_user.build_user_runtastic
      end

      def create
        @object = current_user.build_user_runtastic(object_params)

        if @object.save
          response = @object.perform
          case response
            when 0
              flash[:notice] = 'Usuario o contraseña incorrectos'
              redirect_to action: :new
            else
              flash[:notice] = 'Todos los datos han sido actualizados'
              redirect_to padawan_comunidad_sports_path
          end
        else

        end
      end

      def edit
        @object = current_user.user_runtastic
      end

      def update
        @object = current_user.user_runtastic

        if @object.update_attributes(object_params)
          response = @object.perform
          case response
            when 0
              flash[:alert] = 'Usuario o contraseña incorrectos'
              redirect_to action: :edit
            else
              flash[:notice] = 'Todos los datos han sido actualizados'
              redirect_to padawan_comunidad_sports_path
          end
        else

        end
      end

      private

      def set_objects
        @objects = model.order(created_at: :desc)
      end

      def object_params
        params.require(:user_runtastic).permit(
            :email,
            :password
        )
      end

    end
  end
end
