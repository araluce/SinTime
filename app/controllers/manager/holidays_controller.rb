module Manager
  class HolidaysController < Manager::ManagersController
    before_action :load_resource_name
    before_action :set_open_section

    def load_resource_name
      @resource_name = 'Vacaciones'
    end

    def set_open_section
      @open_section = 'General'
    end

    def index
      @object = model.new
      set_objects
    end

    def create
      @object = model.new(object_params)

      if (@object.days.to_i + @object.hours.to_i + @object.minutes.to_i + @object.seconds.to_i) > 0
        User.find_each do |user|
          holidays_duration = @object.days.to_i.days + @object.hours.to_i.hours + @object.minutes.to_i.minutes + @object.seconds.to_i.seconds
          tdv = user.tdv + holidays_duration
          tsc = DateTime.now + holidays_duration
          tsb = DateTime.now + holidays_duration
          tdv_holidays = DateTime.now + holidays_duration
          tdv_holidays_ref = (user.tdv - DateTime.now).to_i
          user.update_columns(tdv: tdv, tsc: tsc, tsb: tsb, tdv_holidays: tdv_holidays, tdv_holidays_ref: tdv_holidays_ref)
        end
        flash[:notice] = 'Vacaciones en marcha'
      else
        flash[:alert] = 'Debe ingresarse un tiempo'
      end
      redirect_to manager_holidays_path
    end

    private

    def model
      BankingMovement
    end

    def set_objects
      @objects = User.in_holidays.all.map{|user| {user: user, score: user.banking_movements.where(created_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month).map {|banking_movement| banking_movement.seconds_difference }.sum}}.sort_by{|obj| -obj[:score]}
      @user_final_ranking = User.in_holidays.all.map{|user| {user: user, score: user.banking_movements.map {|banking_movement| banking_movement.seconds_difference }.sum}}.sort_by{|obj| -obj[:score]}
    end

    def object_params
      params.require(:object).permit(
          :days, :hours, :minutes, :seconds
      )
    end
  end
end