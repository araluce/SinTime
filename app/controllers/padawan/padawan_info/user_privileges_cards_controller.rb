module Padawan
  module PadawanInfo
    class UserPrivilegesCardsController < Padawan::PadawanInfoController
      layout 'padawan'
      before_action :get_card
      before_action :get_objects, only: :index

      include CardsHelper

      def create
        @object = model.new(object_params)
        check_card_buy

        if @error.nil? && @object.save
          flash[:notice] = 'Has comprado la carta correctamente'
        else
          flash[:alert] = @error
        end

        redirect_to padawan_padawan_info_privileges_card_path(@card)
      end

      private

      def model
        UserPrivilegesCard
      end

      def get_card
        @card = PrivilegesCard.find(params['privileges_card_id'])
      end

      def object_params
        params.permit().merge(privileges_card_id: @card.id, user_id: current_user.id)
      end

    end
  end
end