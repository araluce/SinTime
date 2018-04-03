module Manager
  class BetsController < Manager::ManagersController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit, :pay_and_close, :close, :reopen]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Bet
    end

    def load_resource_name
      @resource_name = 'Apuesta'
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
        redirect_to manager_bet_path(@object), notice: 'Apuesta creada correctamente'
      else
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_bet_path(@object), notice: 'Apuesta actualizada correctamente'
      else
        render :edit
      end
    end

    def pay_and_close
      if @object.open
        BetService.pay_bet(@object)
        @object.update_columns(open: false)
        flash[:notice] = 'Beneficio repartido'
      else
        flash[:alert] = 'La apuesta ya está cerrada'
      end

      redirect_to manager_bet_path(@object)
    end

    def close
      if @object.open
        @object.update_columns(open: false)
        flash[:notice] = 'Apuesta cerrada sin repartos de beneficio'
      else
        flash[:alert] = 'La apuesta ya está cerrada'
      end

      redirect_to manager_bet_path(@object)
    end

    def reopen
      unless @object.open
        @object.update_columns(open: true)
        flash[:notice] = 'Apuesta reabierta'
      else
        flash[:alert] = 'La apuesta ya está abierta'
      end

      redirect_to manager_bet_path(@object)
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_bets_path, notice: 'Apuesta eliminada correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:bet).permit(
          :bet,
          :active,
          :open,
          options_attributes: {}
      )
    end

    def set_object
      @object = model.find_by_id(params[:id] || params[:bet_id])
    end

    def set_objects
      @objects = model.order(created_at: :desc)
    end

  end
end