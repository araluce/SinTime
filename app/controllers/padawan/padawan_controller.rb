module Padawan
  class PadawanController < ApplicationController
    layout 'padawan'

    before_action :authenticate_user!
    before_action :get_tdv

    def home
    end

    def get_tdv
      @tdv = Date.today
    end

  end
end