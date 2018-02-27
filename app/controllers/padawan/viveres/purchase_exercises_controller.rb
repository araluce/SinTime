module Padawan
  module Viveres
    class PurchaseExercisesController < ApplicationController
      before_action :set_object, only: :destroy


      def purchase
        @response = true
        begin
          model.create(exercise_id: params[:exercise_id], user: current_user)
          PayService.pay_exercise(current_user, Exercise.find(params[:exercise_id]))
          @tdv = current_user.tdv
        rescue
          @response = false
        end
      end

      def destroy
        @object.destroy
      end

      private

      def model
        ExerciseUser
      end

      def set_object
        @object = model.find(params[:id])
      end

      def object_params
        params.permit(
            :exercise_id
        ).merge(user: current_user)
      end

    end
  end
end