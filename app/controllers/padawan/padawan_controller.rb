module Padawan
  class PadawanController < ApplicationController
    layout 'padawan'

    before_action :authenticate_user!
    before_action :redirect_if_end
    before_action :get_tdv

    def home
    end

    def get_tdv
      @tdv = current_user.tdv
    end

    def redirect_if_end
      if current_user && current_user.end? && !current_user.untouchable
        redirect_to root_path, notice: 'La experiencia ha finalizado'
      end
    end

  end
end