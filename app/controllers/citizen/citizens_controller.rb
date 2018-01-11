module Citizen
  class CitizensController < ApplicationController
    layout 'citizen'

    before_action :authenticate_user!
    before_action :get_tdv

    def home
    end

    def get_tdv
      @tdv = Date.today
    end

  end
end