module Manager
  class BankingMovementsController < Manager::ManagersController
    before_action :set_citizen
    before_action :set_district

    def create
      if @user
        create_citizen
        redirect_to manager_citizen_path(@user)
      elsif @district
        create_district
        redirect_to manager_district_path(@district)
      end
    end

    def create_citizen
      begin
        time = params[:object][:days].to_i.days + params[:object][:hours].to_i.hours + params[:object][:minutes].to_i.minutes + params[:object][:seconds].to_i.seconds
        PayService.system_pay_reason(@user, time.to_i, params[:object][:reason])
        flash[:notice] = 'Transferencia realizada con éxito'
      rescue
        flash[:alert] = 'Se ha producido un error'
      end
    end

    def create_district
      begin
        time = params[:object][:days].to_i.days + params[:object][:hours].to_i.hours + params[:object][:minutes].to_i.minutes + params[:object][:seconds].to_i.seconds

        @district.users.each do |user|
          PayService.system_pay_reason(user, time.to_i, params[:object][:reason])
        end
        flash[:notice] = 'Transferencia realizada con éxito'
      rescue
        flash[:alert] = 'Se ha producido un error'
      end
    end

    private

    def model
      BankingMovement
    end

    def set_citizen
      @user = User.find_by(id: params['citizen_id'])
    end

    def set_district
      @district = District.find_by(id: params['district_id'])
    end

    def object_params
      params.require(:object).permit(
          :days, :hours, :minutes, :seconds, :reason
      )
    end
  end
end