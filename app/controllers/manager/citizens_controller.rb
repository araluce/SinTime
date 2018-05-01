module Manager
  class CitizensController < Manager::ManagersController
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

    def level_up
      LevelService.level_up @object
      flash[:notice] = 'Operación realizada correctamente'
      redirect_to manager_citizen_path(@object)
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
          :level,
          :xp,
          :district_id
      )
    end

    def set_object
      @object = model.find_by_id(params[:id] || params[:citizen_id])
    end

    def set_objects

      @objects = model.all.map{|user| {user: user, score: user.banking_movements.where(created_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month).map {|banking_movement| banking_movement.seconds_difference }.sum}}.sort_by{|obj| -obj[:score]}
      @user_final_ranking = model.all.map{|user| {user: user, score: user.banking_movements.map {|banking_movement| banking_movement.seconds_difference }.sum}}.sort_by{|obj| -obj[:score]}
    end

  end
end