module Padawan
  module Felicidad
    class AudienciaController < Padawan::PadawanController
      layout 'padawan'
      before_action :set_objects

      def model
        Exercise::Happiness
      end

      def index
        flash[:notice] = 'Esta sección ya no está activa'
        redirect_to padawan_home_path
      end

      def create
        @object = current_user.exercise_users.new(object_params)


        if @object.save
          max_days = Constant.find_by_key('felicidad dias entre entregas').value.to_i
          flash[:notice] = "Se ha entregado la propuesta correctamente, podrás entregar la evidencia transcurridos #{max_days} días desde hoy"
          redirect_to action: :index
        else
          flash[:notice] = 'Se han producido errores'
          @errors = @object.errors
          render 'index'
        end
      end

      def update
        @object = current_user.exercise_users.find(params[:id])

        if @object.update_attributes(object_params)
          flash[:notice] = 'Se ha entregado la evidencia correctamente'
          redirect_to action: :index
        else
          flash[:alert] = @object.errors.full_messages
          redirect_to action: :index
        end
      end

      private

      def set_objects
        @objects = model.order(created_at: :desc)
      end

      def object_params
        params.require(:object).permit(
         :file,
         :second_file,
         :exercise_id
        ).merge(status: 'Entregado')
      end
    end
  end
end
