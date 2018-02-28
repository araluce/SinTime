module Manager
  class DeliveriesController < ApplicationController
    layout 'manager'

    before_action :set_object, only: [:update, :destroy, :edit]
    before_action :set_objects, except: [:edit, :update]
    before_action :authenticate_admin!
    before_action :load_resource_name
    before_action :set_open_section

    def model
      ExerciseUser
    end

    def load_resource_name
      @resource_name = 'Entregas'
    end

    def set_open_section
      @open_section = 'Ejercicios'
    end

    def index
      @object = model.new
    end

    def edit
    end

    def update
      if @object.update(object_params)
        PayService.pay_score(@object)
        redirect_to manager_deliveries_path, notice: 'Ejercicio calificado correctamente'
      else
        render :edit
      end
    end

    private

    def object_params
      params.require(:exercise_user).permit(
          :score_id
      ).merge(status: 'Corregido')
    end

    def set_object
      @object = model.find(params[:id])
    end

    def set_objects
      @objects = model.entregado.order(created_at: :desc)
    end

  end
end