module Padawan
  module Comunidad
    class DeteccionController < Padawan::ComunidadController
      before_action :set_objects, only: :index
      before_action :set_object, only: :show

      def model
        Bet
      end

      def index
      end

      def show
        @bet_option_user = current_user.bet_option_user.build
      end

      private

      def set_objects
        @objects = model.actives.order(created_at: :desc)
      end

      def set_object
        @object = model.find_by(id: params[:id])
      end

    end
  end
end
