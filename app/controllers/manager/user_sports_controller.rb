module Manager
  class UserSportsController < Manager::ManagersController
    before_action :set_user
    before_action :load_resource_name
    before_action :set_open_section


    def load_resource_name
      @resource_name = 'Ciudadano'
    end

    def set_open_section
      @open_section = 'General'
    end

    def index
      @dates = []
      (@user.user_runtastic.created_at.to_date..Date.today).each {|final_date| @dates << final_date unless (1..6).include?(final_date.wday)} if @user.user_runtastic
    end

    private

    def set_user
      @user = User.find(params[:citizen_id])
    end

  end
end