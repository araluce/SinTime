module Padawan
  module PadawanInfo
    class MovimientosController < Padawan::PadawanInfoController
      layout 'padawan'
      before_action :get_objects

      def index
      end

      private

      def get_objects
        @objects = current_user.banking_movements.order(created_at: :desc)
      end

    end
  end
end