module Manager
  class DistrictsController < Manager::ManagersController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :load_resource_name
    before_action :set_open_section

    def model
      District
    end

    def load_resource_name
      @resource_name = 'District'
    end

    def set_open_section
      @open_section = 'General'
    end

    def object_initialization
    end

    def index
      @object = model.new
      @objects = model.order(created_at: :desc)
    end

    def show
    end

    def new
      @object = model.new
    end

    def create
      @object = model.new(object_params)

      if @object.save
        redirect_to manager_district_path(@object), notice: 'Distrito creado correctamente'
      else
        object_initialization
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_district_path(@object), notice: 'Distrito actualizado correctamente'
      else
        object_initialization
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_districts_path, notice: 'Distrito eliminado correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:district).permit(
          :name,
          :logo,
          user_ids: []
      )
    end

    def set_object
      @object = model.find_by_id(params[:id])
    end

  end
end