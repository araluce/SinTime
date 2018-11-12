module Manager
  class AudiencesController < Manager::ManagersController
    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Exercise::Audience
    end

    def load_resource_name
      @resource_name = 'Audiencia'
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
        redirect_to manager_audience_path(@object), notice: 'Reto de audiencia creado correctamente'
      else
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_audience_path, notice: 'Reto de audiencia actualizado correctamente'
      else
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_audiences_path, notice: 'Reto de audiencia eliminado correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:object).permit(
          :icon,
          :title,
          :statement,
          benefit_scores_attributes: {}
      ).merge(district: true)
    end

    def set_object
      @object = model.find_by_id(params[:id])
    end

    def set_objects
      @objects = model.order(created_at: :desc)
    end

  end
end