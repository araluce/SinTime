module Manager
  class ManagersController < ApplicationController
    layout 'manager'

    before_action :authenticate_admin!

    def home
    end

  end
end