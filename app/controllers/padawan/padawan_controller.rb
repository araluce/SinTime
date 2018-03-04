module Padawan
  class PadawanController < ApplicationController
    layout 'galactic_padawan'

    before_action :authenticate_user!
    before_action :get_tdv

    def home
    end

    def get_tdv
      @tdv = current_user.tdv
    end

  end
end