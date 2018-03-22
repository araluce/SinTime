module Manager
  class BankingMovementsController < Manager::ManagersController
    before_action :set_citizen

    def create
      begin
        time = params[:object][:days].to_i.days + params[:object][:hours].to_i.hours + params[:object][:minutes].to_i.minutes + params[:object][:seconds].to_i.seconds
        PayService.system_pay_reason(@user, time.to_i, params[:object][:reason])
        flash[:notice] = 'Transferencia realizada con éxito'
      rescue
        flash[:alert] = 'Se ha producido un error'
      end
      redirect_to manager_citizen_path(@user)
    end

    private

    def model
      BankingMovement
    end

    def set_citizen
      @user = User.find_by(id: params['citizen_id'])
    end

    def object_params
      params.require(:object).permit(
          :days, :hours, :minutes, :seconds, :reason
      )
    end
  end
end