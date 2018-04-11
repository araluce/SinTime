module Manager
  class CitizensController < Manager::ManagersController
    layout 'manager'

    before_action :set_object, except: [:new, :create]
    before_action :set_objects, only: [:index]
    before_action :load_resource_name
    before_action :set_open_section

    def model
      User
    end

    def load_resource_name
      @resource_name = 'Ciudadano'
    end

    def set_open_section
      @open_section = 'General'
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
    end

    def create
      @object = model.new(object_params)
      @object.password = @object.password || @object.dni

      if @object.save
        redirect_to manager_citizen_path(@object), notice: 'Ciudadano creado correctamente'
      else
        object_initialization
        set_objects
        render :index, error: @object.errors
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_citizen_path(@object), notice: 'Ciudadano actualizado correctamente'
      else
        object_initialization
        set_objects
        render :edit, error: @object.errors
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_citizen_path, notice: 'Ciudadano eliminado correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:user).permit(
          :avatar,
          :name,
          :lastname,
          :dni,
          :email,
          :alias,
          :password,
          :district_id
      )
    end

    def set_object
      @object = model.find_by_id(params[:id])
    end

    def set_objects
      @objects = model.order(email: :desc)
    end

  end
end