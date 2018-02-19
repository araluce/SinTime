module Padawan
  class InformationController < Padawan::PadawanInfoController
    before_action :get_object

    def edit

    end

    def update

      render :edit
    end

    private

    def get_object
      User.find(params[:id])
    end

    def object_params
      params.require(:user).permit(
          :icon,
          :statement,
          :feeding_type,
          :days_benefit,
          :hours_benefit,
          :minutes_benefit,
          :seconds_benefit
      )
    end

  end
end