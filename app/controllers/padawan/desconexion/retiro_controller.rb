module Padawan
  module Desconexion
    class RetiroController < Padawan::ComunidadController

      def index
      end

      def create
        if current_user.have_holidays
          holidays_duration = 604800
          tdv = current_user.tdv + holidays_duration
          tsc = DateTime.now + holidays_duration
          tsb = DateTime.now + holidays_duration
          tdv_holidays = DateTime.now + holidays_duration
          tdv_holidays_ref = (current_user.tdv - DateTime.now).to_i
          current_user.update_columns(tdv: tdv, tsc: tsc, tsb: tsb, tdv_holidays: tdv_holidays, tdv_holidays_ref: tdv_holidays_ref, have_holidays: false)
          PayService.user_pay_reason(current_user, 216000, 'Vacaciones')
          flash[:notice] = 'Vacaciones en marcha!'
          redirect_to action: :index
        else
          flash[:alert] = 'Ya has gastado tus vacaciones'
          render 'index'
        end
      end

    end
  end
end
