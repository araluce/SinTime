module Manager
  class PrivilegesCardsController < Manager::ManagersController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :load_resource_name
    before_action :set_open_section

    def model
      PrivilegesCard
    end

    def load_resource_name
      @resource_name = 'Cartas de privilegio'
    end

    def set_open_section
      @open_section = 'General'
    end

    def index
      @object = model.new
    end

    def show
    end

    def create
      @object = model.new(object_params)

      if @object.save
        redirect_to manager_privileges_card_path(@object), notice: 'Carta de privilegio creada correctamente'
      else
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_privileges_cards_path, notice: 'Carta de privilegios actualizada correctamente'
      else
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_privileges_cards_path, notice: 'Carta de privilegios eliminada correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:object).permit(
          :card,
          :title,
          :description,
          :identifier,
          :xp_cost
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