module Manager
  class WaterController < ApplicationController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :authenticate_admin!
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Exercise::Feeding
    end

    def load_resource_name
      @resource_name = 'Agua'
    end

    def set_open_section
      @open_section = 'Ejercicios'
    end

    def object_initialization
      @object.feeding_type = 'Agua'
      @object.benefit_scores.build
    end

    def index
      @object = model.new
    end

    def show
    end

    def new
      @object = model.new
      object_initialization
    end

    def create
      @object = model.new(object_params)
      object_initialization

      if @object.save
        redirect_to manager_water_path(@object), notice: 'Reto de agua creado correctamente'
      else
        object_initialization
        render :index
      end
    end

    def edit
      object_initialization
    end

    def update
      object_initialization
      if @object.update(object_params)
        redirect_to manager_water_path, notice: 'Reto de agua actualizado correctamente'
      else
        object_initialization
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_water_index_path, notice: 'Reto de agua eliminado correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:exercise_feeding).permit(
          :icon,
          :title,
          :statement,
          :feeding_type,
          :days_benefit,
          :hours_benefit,
          :minutes_benefit,
          :seconds_benefit
      ).merge(feeding_type: 'Agua')
    end

    def set_object
      @object = model.water.find_by_id(params[:id])
    end

    def set_objects
      @objects = model.water.order(created_at: :desc)
    end

  end
end