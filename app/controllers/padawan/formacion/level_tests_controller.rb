module Padawan
  module Formacion
    class LevelTestsController < Padawan::PadawanController
      before_action :set_objects
      before_action :set_object, except: :index
      before_action :set_delivery, only: [:edit, :update]

      def model
        Exercise::LevelTest
      end

      def index
      end

      def edit
      end

      def update
        if @delivery.update_attributes(object_params)
          flash[:notice] = 'Entrega realizada correctamente'
        else
          flash[:alert] = @object.errors.full_messages
        end
        redirect_to action: :index
      end

      def purchase
        if current_user.exercise_users.where(exercise: @object).any?
          flash[:alert] = 'Ya has comprado este reto'
        else
          if !@object.is_complete?
            current_user.exercise_users.create(exercise: @object, status: 'Comprado')
            PayService.pay_exercise(current_user, @object, 'Compra')
            flash[:notice] = 'Reto comprado correctamente'
          else
            flash[:alert] = 'Este reto ha alcanzado su límite'
          end
        end
        redirect_to action: :index
      end

      private

      def set_objects
        @objects = model.order(created_at: :desc)
      end

      def set_object
        @object = model.find_by(id: params[:id] || params[:level_test_id])
      end

      def set_delivery
        @delivery = current_user.exercise_users.where(exercise: @object).first
      end

      def object_params
        params.require(:object).permit(:file).merge(status: 'Entregado')
      end
    end
  end
end
