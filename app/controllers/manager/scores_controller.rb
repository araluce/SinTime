module Manager
  class ScoresController < Manager::ManagersController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Score
    end

    def load_resource_name
      @resource_name = 'Calificaciones'
    end

    def set_open_section
      @open_section = 'General'
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
        redirect_to manager_score_path(@object), notice: 'Calificación creada correctamente'
      else
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_score_path, notice: 'Calificación actualizada correctamente'
      else
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_scores_path, notice: 'Calificación eliminada correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:score).permit(
          :title,
          :icon,
          :days_benefit,
          :hours_benefit,
          :minutes_benefit,
          :seconds_benefit
      )
    end

    def set_object
      @object = model.find(params[:id])
    end

    def set_objects
      @objects = model.order(created_at: :desc)
    end

  end
end