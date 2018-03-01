module Padawan
  module PadawanInfo
    class InformationController < Padawan::PadawanInfoController
      layout 'profile'
      before_action :get_object

      def index
      end

      def update
        if @object.update(object_params)
          redirect_to padawan_padawan_info_information_index_path, notice: 'Perfil actualizado correctamente'
        else
          @errors = @object.errors
          render :index
        end
      end

      private

      def get_object
        @object = current_user
      end

      def object_params
        params.require(:user).permit(
            :alias,
            :avatar,
            :name,
            :lastname,
            :dob,
            :password,
            :password_confirmation,
            :email
        )
      end

    end
  end
end