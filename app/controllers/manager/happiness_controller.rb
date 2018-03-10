module Manager
  class HappinessController < ApplicationController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :authenticate_admin!
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Exercise::Happiness
    end

    def load_resource_name
      @resource_name = 'Felicidad'
    end

    def set_open_section
      @open_section = 'Ejercicios'
    end

    def object_initialization
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
        redirect_to manager_happiness_path(@object), notice: 'Reto de felicidad creado correctamente'
      else
        object_initialization
        render :index
      end
    end

    def edit
      object_initialization
    end

    def update
      if @object.update(object_params)
        redirect_to manager_happiness_path, notice: 'Reto de felicidad actualizado correctamente'
      else
        object_initialization
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_happiness_path, notice: 'Reto de felicidad eliminado correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:object).permit(
          :title,
          benefit_scores_attributes: {}
      ).merge(days_benefit: 0, hours_benefit: 0, minutes_benefit: 0, seconds_benefit: 1, statement: 'Reto de felicidad')
    end

    def set_object
      @object = model.find_by_id(params[:id])
    end

    def set_objects
      @objects = model.order(created_at: :desc)
    end

  end
end