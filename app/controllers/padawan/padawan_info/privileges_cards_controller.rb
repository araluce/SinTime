module Padawan
  module PadawanInfo
    class PrivilegesCardsController < Padawan::PadawanInfoController
      layout 'padawan'
      before_action :get_object, only: :show
      before_action :get_objects, only: :index

      def index
      end

      def show
      end

      private

      def model
        PrivilegesCard
      end

      def get_objects
        @objects = model.active.order(created_at: :desc).page(params[:page])
      end

      def get_object
        @object = model.find_by(id: params[:id])
      end

    end
  end
end