module Padawan
  module Formacion
    class ForceDomainsController < Padawan::PadawanController
      before_action :set_objects, only: :show
      before_action :set_object, except: :show

      def model
        Exercise::Questionnaire
      end

      def show
      end

      def edit
        @object.user_questionnaires.build(user: current_user)
      end

      def update
        @object = model.new(object_params)
        if @object.save
          render 'create.js.coffee.erb'
        else
          flash[:alert] = @object.errors.full_messages
          render :edit
        end
      end

      private

      def set_objects
        @objects = model.order(created_at: :desc)
      end

      def set_object
        @object = model.find_by(id: params[:id])
      end

      def object_params
        params.require(:object).permit(
            user_questionnaires_attributes: {}
        )
      end
    end
  end
end
