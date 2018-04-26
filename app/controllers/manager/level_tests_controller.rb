module Manager
  class LevelTestsController < Manager::ManagersController
    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Exercise::LevelTest
    end

    def load_resource_name
      @resource_name = 'Prueba de nivel'
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
      @exercise_users = @object.exercise_users
    end

    def new
      @object = model.new
      object_initialization
    end

    def create
      @object = model.new(object_params)
      object_initialization

      if @object.save
        redirect_to manager_level_test_path(@object), notice: 'Prueba de nivel creada correctamente'
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
        redirect_to manager_level_tests_path, notice: 'Prueba de nivel actualizada correctamente'
      else
        object_initialization
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_level_tests_path, notice: 'Prueba de nivel eliminada correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:exercise_level_test).permit(
          :title,
          :statement,
          :max_applicants,
          :days_benefit,
          :hours_benefit,
          :minutes_benefit,
          :seconds_benefit,
          benefit_scores_attributes: {}
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