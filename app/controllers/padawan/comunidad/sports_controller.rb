module Padawan
  module Comunidad
    class SportsController < Padawan::ComunidadController
      layout 'padawan'
      before_action :set_objects

      def model
        Exercise::Sport
      end

      def index
        @user_runtastic = current_user.user_runtastic
        if @user_runtastic
          response = @user_runtastic.perform
          case response
            when 0
              flash[:notice] = 'Usuario o contraseña incorrectos'
              redirect_to edit_padawan_comunidad_login_path(@user_runtastic)
            else
              @sessions = @user_runtastic.activity_logs.week
              render 'index'
          end
        else
          flash[:notice] = 'Debes registrarte en Runtastic'
          redirect_to new_padawan_comunidad_login_path
        end
      end

      private

      def set_objects
        @objects = model.order(created_at: :desc)
      end
    end
  end
end
