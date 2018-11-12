module Padawan
  module Viveres
    class PurchaseExercisesController < ApplicationController
      before_action :set_object, only: [:purchase, :rewind]

      def purchase
        @response = true
        begin
          deliveries = current_user.exercise_users.comprado.where(exercise_id: params[:exercise_id])
          if @object.is_water?
            if @object.is_individual?
              deliveries = deliveries.water.individual
            else
              deliveries = deliveries.water.clan
            end
          else
            if @object.is_individual?
              deliveries = deliveries.food.individual
            else
              deliveries = deliveries.food.clan
            end
          end

          unless deliveries.any?
            model_exercise_user.create(exercise_id: params[:exercise_id], user: current_user)
            PayService.pay_exercise(current_user, @object, 'Compra')
            set_request_params
          else
            @response = false
          end
        rescue
          @response = false
        end
        render 'padawan/js_templates/exercise_preview.js.erb'
      end

      def rewind
        @response = true
        matches = model_exercise_user.where(exercise_id: params[:exercise_id], user: [current_user], status: 'Comprado')
        if matches.any?
          matches.first.destroy
          PayService.rewind_exercise(current_user, @object, 'Cancelación de compra')
          set_request_params
        else
          @response = false
        end
        render 'padawan/js_templates/exercise_preview.js.erb'
      end

      def destroy
        @object.destroy
      end

      private

      def model
        Exercise
      end

      def model_exercise_user
        ExerciseUser
      end

      def set_object
        @object = model.find(params[:exercise_id])
      end

      def set_request_params
        if @object.is_food?
          @my_deliveries = current_user.food_deliveries
        else
          @my_deliveries = current_user.water_deliveries
        end
        @tdv = current_user.tdv
      end

      def object_params
        params.permit(
            :exercise_id
        ).merge(user: current_user)
      end

    end
  end
end