module Padawan
  module Viveres
    class FoodController < Padawan::ViveresController
      before_action :set_objects

      def model
        Exercise::Feeding
      end

      def index
        @object = model.new
      end

      private

      def set_objects
        @objects = model.food.order(created_at: :desc)
      end

    end
  end
end