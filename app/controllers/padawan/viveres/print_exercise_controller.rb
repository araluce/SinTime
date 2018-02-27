module Padawan
  module Viveres
    class PrintExerciseController < Padawan::ViveresController
      before_action :set_object

      def model
        Exercise::Feeding
      end

      def show
        @my_deliveries = current_user.exercise_users
        render 'padawan/js_templates/exercise_preview.js.erb'
      end

      private

      def set_object
        @object = model.find_by_id(params[:id])
      end

    end
  end
end
