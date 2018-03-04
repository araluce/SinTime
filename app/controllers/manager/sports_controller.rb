module Manager
  class SportsController < ApplicationController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :authenticate_admin!
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Exercise::Sport
    end

    def load_resource_name
      @resource_name = 'Deportes'
    end

    def set_open_section
      @open_section = 'Ejercicios'
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

      if @object.save
        redirect_to manager_sport_path(@object), notice: 'Reto deportivo creado correctamente'
      else
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_sport_path, notice: 'Reto deportivo actualizado correctamente'
      else
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_sports_path, notice: 'Reto deportivo eliminado correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:exercise_sport).permit(
          :statement,
          :pace,
          :speed,
          :days_running,
          :hours_running,
          :minutes_running,
          :seconds_running,
          :days_cycling,
          :hours_cycling,
          :minutes_cycling,
          :seconds_cycling,
          :days_benefit,
          :hours_benefit,
          :minutes_benefit,
          :seconds_benefit
      )
    end

    def set_object
      @object = model.find_by_id(params[:id])
    end

    def set_objects
      @objects = model.order(created_at: :desc)
    end

  end
end