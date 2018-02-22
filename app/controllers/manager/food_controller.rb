module Manager
  class FoodController < ApplicationController
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
      @resource_name = 'Comida'
    end

    def set_open_section
      @open_section = 'Ejercicios'
    end

    def object_initialization
      @object.feeding_type = 'Comida'
    end

    def index
      @object = model.new
    end

    def show
    end

    def new
      @object = model.new
    end

    def create
      @object = model.new(object_params)
      object_initialization

      if @object.save
        redirect_to manager_food_path(@object), notice: 'Reto de comida creado correctamente'
      else
        object_initialization
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_food_path, notice: 'Reto de agua comida correctamente'
      else
        object_initialization
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_food_index_path, notice: 'Reto de comida eliminado correctamente'}
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
      )
    end

    def set_object
      @object = model.food.find_by_id(params[:id])
    end

    def set_objects
      @objects = model.food.order(created_at: :desc)
    end

  end
end