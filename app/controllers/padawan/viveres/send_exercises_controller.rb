module Padawan
  module Viveres
    class SendExercisesController < ApplicationController
      before_action :set_object, only: [:update]

      def update
        if @object.exercise.is_individual?
          send_exercise
        else
          if current_user.district
            users = current_user.district.users
            can_sent = true
            users.each do |user|
              can_sent = false if user.exercise_users.comprado.where(exercise: @object.exercise).empty?
            end

            if can_sent
              send_exercise
            else
              flash[:notice] = 'Para poder entregar todos los miembros de tu clan deben comprar el reto'
              redirect_to_index
            end
          else
            flash[:notice] = 'No puedes entregar, no perteneces a ningún distrito'
            redirect_to_index
          end
        end
      end

      def send_exercise
        if @object.is_comprado?
          if @object.update_attributes(object_params)
            flash[:notice] = 'Entrega realizada correctamente'
            if @object.exercise.type == 'Exercise::Feeding'
              current_user.update_columns(tsc: DateTime.now) if @object.exercise.is_food?
              current_user.update_columns(tsb: DateTime.now) if @object.exercise.is_water?
            end
          else
            flash[:alert] = 'Se ha producido un error'
          end
        else
          flash[:error] = 'Ya se ha entregado este reto'
        end

        redirect_to_index
      end

      def redirect_to_index
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