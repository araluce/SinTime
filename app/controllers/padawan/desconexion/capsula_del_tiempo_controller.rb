module Padawan
  module Desconexion
    class CapsulaDelTiempoController < Padawan::ComunidadController
      before_action :set_objects, except: :show
      before_action :set_object, only: [:show, :pay_all, :pay_share]

      def model
        Loan
      end

      def index
        @object = model.new
      end

      def show
      end

      def create
        @object = model.new(object_params)
        @object.interest = Constant.find_by_key('intereses').value.to_f

        if (@object.user.tdv - DateTime.now).to_i >= 7.days.to_i
          flash[:alert] = 'Tienes más de 7 días de vida'
          render 'index'
        else
          if @object.save
            interest = 1 + @object.interest
            @object.update_columns(time_loan: @object.time_loan * interest, time_remaining: @object.time_remaining * interest )
            PayService.system_pay_reason(@object.user, @object.time_loan, 'Préstamo solicitado')
            flash[:notice] = 'Préstamo concedido'
            redirect_to action: :index
          else
            flash[:alert] = 'Se ha producido un error'
            render 'index'
          end
        end

      end

      def pay_all
        if (@object.user.tdv - DateTime.now).to_i - @object.time_remaining >= 0
          PayService.user_pay_reason(@object.user, @object.time_remaining, 'Préstamo pagado al completo')
          @object.update_columns(share_remaining: 0, time_remaining: 0)
          flash[:notice] = 'Su préstamo ha sido completamente pagado'
          redirect_to action: :index
        else
          flash[:alert] = 'No tienes suficiente TDV'
          render 'index'
        end
      end

      def pay_share
        if (@object.user.tdv - DateTime.now).to_i - @object.time_per_share >= 0
          PayService.user_pay_reason(@object.user, @object.time_remaining, 'Cuota pagada')
          @object.update_columns(share_remaining: @object.share_remaining - 1, time_remaining: @object.time_remaining - @object.time_per_share)
          flash[:notice] = 'Cuota pagada'
          redirect_to action: :index
        else
          flash[:alert] = 'No tienes suficiente TDV'
          render 'index'
        end
      end

      private

      def set_objects
        @objects = model.where(user: current_user).order(created_at: :desc)
      end

      def set_object
        @object = model.find_by(id: params[:id] || params[:capsula_del_tiempo_id])
      end

      def object_params
        params.require(:object).permit(
            :days_loan,
            :hours_loan,
            :minutes_loan,
            :seconds_loan,
            :share
        ).merge(user_id: current_user.id)
      end

    end
  end
end
