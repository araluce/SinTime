module Padawan
  module Comunidad
    module Altruismo
      class DonationsController < Padawan::Comunidad::AltruismoController

        def new
          @object = model.new
        end

        def create
          @object = model.new(object_params)

          if user_permitted?(@object.receiver)
            set_seconds_donated
            if @object.save
              begin
                PayService.user_pay_reason(@object.sender, @object.seconds_donated, @object.to_s)
                PayService.system_pay_reason(@object.receiver, @object.seconds_donated, @object.to_s)
                flash[:notice] = 'Donación realizada correctamente'
                redirect_to action: :new
              rescue
                flash[:alert] = 'Se ha producido un error en el proceso de pago'
                render :new
              end

            else
              @errors = @object.errors
              render :new
            end
          else
            flash[:alert] = 'El padawan al que intentas donar tiene más de 7 días'
            render :new
          end
        end

        private

        def user_permitted?(user)
          (user.tdv - DateTime.now) >= 7
        end

        def set_seconds_donated
          @object.seconds_donated = (@object.days.to_i.days + @object.hours.to_i.hours + @object.minutes.to_i.minutes + @object.seconds.to_i.seconds).to_i
        end

        def model
          Donation
        end

        def object_params
          params.require(:object).permit(
              :days, :hours, :minutes, :seconds, :receiver_id
          ).merge(sender_id: current_user.id)
        end

      end
    end
  end
end