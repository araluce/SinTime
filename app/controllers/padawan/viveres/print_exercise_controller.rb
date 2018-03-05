module Padawan
  module Viveres
    class PrintExerciseController < Padawan::ViveresController
      before_action :set_object

      def model
        Exercise::Feeding
      end

      def show
        if @object.is_food?
          @my_deliveries = current_user.food_deliveries
        else
          @my_deliveries = current_user.water_deliveries
        end
        @response = true
        @tdv = current_user.tdv
        render 'padawan/js_templates/exercise_preview.js.erb'
      end

      private

      def set_object
        @object = model.find_by_id(params[:id])
      end

    end
  end
end
