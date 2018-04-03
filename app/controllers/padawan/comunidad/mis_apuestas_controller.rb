module Padawan
  module Comunidad
    class MisApuestasController < Padawan::ComunidadController
      before_action :set_object

      def model
        Bet
      end

      def create
        @bet_option_user = current_user.bet_option_user.build(object_params)

        if @bet_option_user.save
          flash[:notice] = 'Tu apuesta se ha realizado correctamente'
        else
          flash[:alert] = @bet_option_user.errors.full_messages
        end

        redirect_to padawan_comunidad_deteccion_path(@bet)
      end

      private

      def object_params
        params.require(:bet_option_user).permit(
          :bet_option_id,
          :days_bet,
          :hours_bet,
          :minutes_bet,
          :seconds_bet
        )
      end

      def set_object
        @bet = Bet.find_by(id: params[:deteccion_id])
      end

    end
  end
end
