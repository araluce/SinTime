module Manager
  class SalaController < Manager::ManagersController
    layout 'chat'

    def index
      @districts = District.all
      @users = User.all
      @admins = Admin.all
    end

  end
end