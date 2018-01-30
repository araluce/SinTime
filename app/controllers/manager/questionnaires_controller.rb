module Manager
  class QuestionnairesController < ApplicationController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :authenticate_admin!
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Exercise::Questionnaire
    end

    def load_resource_name
      @resource_name = 'Cuestionario'
    end

    def set_open_section
      @open_section = 'Ejercicios'
    end

    def object_initialization
    end

    def index
      @object = model.new
      @objects = model.order(created_at: :desc).page(params[:page])
    end

    def show
    end

    def new
      @object = model.new
    end

    def create
      @object = model.new(object_params)

      if @object.save
        redirect_to manager_questionnaire_path(@object), notice: 'Cuestionario creado correctamente'
      else
        object_initialization
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_questionnaire_path, notice: 'Cuestionario actualizado correctamente'
      else
        object_initialization
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_questionnaires_path, notice: 'Cuestionario eliminado correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:exercise_questionnaire).permit(
          :statement,
          :days_benefit,
          :hours_benefit,
          :minutes_benefit,
          :seconds_benefit,
          :icon,
          options_attributes: {}
      )
    end

    def set_object
      @object = model.find_by_id(params[:id])
    end

  end
end