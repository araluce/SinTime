module Padawan
  module Viveres
    class WaterController < Padawan::ViveresController
      before_action :set_objects

      def model
        Exercise::Feeding
      end

      def index
        @object = model.new
      end

      private

      def set_objects
        @objects = model.water.order(created_at: :desc)
      end

    end
  end
end