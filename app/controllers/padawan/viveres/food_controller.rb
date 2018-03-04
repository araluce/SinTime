module Padawan
  module Viveres
    class FoodController < Padawan::ViveresController
      layout 'padawan'

      before_action :set_objects
      before_action :percentage

      include TimeHelper

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

      def percentage
        tsc_default = Constant.find_by_key('tiempo sin comer');
        tsc_default_time = seconds_to_duration(tsc_default.value)

        @percentage = 1 - ((datetime_to_seconds(DateTime.now) - datetime_to_seconds(current_user.tsc)) / tsc_default_time.value.to_f)
      end

    end
  end
end