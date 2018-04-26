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
        redirect_to action: :show if @object.user_questionnaires.where(user: current_user).any?
        @user_questionnaire = UserQuestionnaire.new(questionnaire: @object, user: current_user)
        @object.user_questionnaires.build(user: current_user)
      end

      def create
        @user_questionnaire = UserQuestionnaire.new(object_params)
        if @user_questionnaire.save
          PayService.system_pay_reason(current_user, 1.day.to_i, 'Dominio de la fuerza superado') if @user_questionnaire.all_right?
        else
          flash[:alert] = @user_questionnaire.errors.full_messages
        end
        redirect_to action: :show
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
          :user_id,
          :questionnaire_id,
          option_ids: []
        )
      end
    end
  end
end
