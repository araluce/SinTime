module Padawan
  module Comunidad
    module Altruismo
      class MinesController < Padawan::Comunidad::AltruismoController
        before_action :set_objects
        before_action :set_object, only: [:show, :detach, :purchase_clue]
        before_action :set_availables_card

        def index
        end

        def show
        end

        def detach
          if params[:object][:code].parameterize == @object.code.parameterize
            result = UserMine.create(user: current_user, mine: @object)
            if result.valid?
              flash[:notice] = 'Enhorabuena! Mina desactivada'
            else
              flash[:alert] = result.errors.full_messages.sum
            end
          else
            flash[:alert] = 'Código incorrecto'
          end
          redirect_to padawan_comunidad_altruismo_mine_path @object
        end

        def purchase_clue
          if @num_cards_availables > 0
            clues = @object.clues - current_user.clues.where(mine: @object)
            if clues.any?
              _card = PrivilegesCard.find_by_identifier 2
              UserClue.create(user: current_user, clue: clues.first)
              current_user.user_privileges_cards.where(privileges_card: _card, active: true).last.update_columns(active: false)
              flash[:notice] = 'Pista comprada'
            else
              flash[:alert] = 'No hay más pistas por el momento'
            end
          else
            flash[:alert] = 'No tienes cartas suficientes'
          end

          redirect_to padawan_comunidad_altruismo_mine_path @object
        end

        private

        def model
          Mine
        end

        def set_object
          @object = model.find(params[:id] || params[:mine_id])
        end

        def set_availables_card
          _card = PrivilegesCard.find_by_identifier 2
          @num_cards_availables = current_user.user_privileges_cards.where(privileges_card: _card, active: true).count
        end

        def set_objects
          @objects = model.order(created_at: :desc)
        end

        def object_params
          params.require(:object).permit(
              :code
          )
        end

      end
    end
  end
end