module Manager
  class MovimientosController < Manager::ManagersController
    before_action :set_user
    before_action :set_objects
    before_action :load_resource_name
    before_action :set_open_section


    def load_resource_name
      @resource_name = 'Movimientos'
    end

    def set_open_section
      @open_section = 'General'
    end

    def index
    end

    private

    def set_user
      @user = User.find(params[:citizen_id])
    end

    def set_objects
      @objects = @user.banking_movements.order(created_at: :desc)
    end

  end
end