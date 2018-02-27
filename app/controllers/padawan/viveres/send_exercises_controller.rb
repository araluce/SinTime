module Padawan
  module Viveres
    class SendExercisesController < ApplicationController
      before_action :set_object, only: [:update]

      def update
        if @object.is_comprado?
          flash[:notice] = 'Entrega realizada correctamente'
          @object.update_attributes(object_params)
        else
          flash[:error] = 'Ya se ha entregado este ejercicio'
        end

        case @object.exercise.type_to_s
          when 'Agua'
            redirect_to padawan_viveres_water_index_path
          when 'Comida'
            redirect_to padawan_viveres_food_index_path
        end
      end

      private

      def model
        ExerciseUser
      end

      def set_object
        @object = model.find(params[:id])
      end

      def object_params
        params.require(:exercise_user).permit(
            :file
        ).merge(user: current_user, status: 'Entregado')
      end

    end
  end
end