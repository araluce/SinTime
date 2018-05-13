module Padawan
  module Formacion
    class AudiencesController < Padawan::FormacionController
      before_action :set_object

      include TimeHelper

      def model
        Exercise::Audience
      end

      def edit
        if @object.nil?
          flash[:notice] = 'Aún no está abierto el periodo de entrega'
          redirect_to padawan_formacion_path
        else
          set_delivery
          render :index
        end
      end

      def update
        @delivery = ExerciseUser.new(delivery_params)
      end

      private

      def set_object
        @object = model.first
      end

      def set_delivery
        @delivery = current_user.group_delivery_by_exercise(@object).first
        @delivery = current_user.exercise_users.build(exercise: @object) if @delivery.nil?
      end

      def delivery_params
        params.require(:object).permit(
            :file,
            :exercise_id,
            :user_id
        ).merge(status: 'Entregado')
      end

    end
  end
end