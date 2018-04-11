module Manager
  class UserDeliveriesController < Manager::ManagersController
    before_action :set_object, only: [:update, :edit]
    before_action :set_user
    before_action :set_objects
    before_action :load_resource_name
    before_action :set_open_section

    def model
      ExerciseUser
    end

    def load_resource_name
      @resource_name = 'Entregas'
    end

    def set_open_section
      @open_section = 'General'
    end

    def index
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_citizen_user_deliveries_path, notice: 'Entrega modificada correctamente'
      else
        render :edit
      end
    end

    private

    def object_params
      params.require(:exercise_user).permit(
          :score_id,
          :file,
          :status
      )
    end

    def set_object
      @object = model.find(params[:id])
    end

    def set_user
      @user = User.find(params[:citizen_id])
    end

    def set_objects
      @objects = @user.exercise_users.order(created_at: :desc)
    end

  end
end