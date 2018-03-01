module Manager
  class PadawanRegistersController < ApplicationController
    layout 'manager'

    before_action :set_objects, only: [:index]
    before_action :authenticate_admin!
    before_action :load_resource_name
    before_action :set_open_section

    def model
      User
    end

    def load_resource_name
      @resource_name = 'Crear padawans'
    end

    def set_open_section
      @open_section = 'General'
    end

    def new
      @object = model.new
    end

    def create
      @object = model.new(object_params)
      dnis = @object.dni_list.gsub('\n', ' ').split

      dnis.each do |dni|
        user = model.new(dni: dni, tdv: Date.today + 15.days, tsc: DateTime.now, tsb: DateTime.now, email: dni)
        user.save(validate: false)
      end

      flash[:notice] = 'Padawans creados correctamente'
      render :new
    end

    private

    def object_params
      params.require(:user).permit(
          :dni_list
      )
    end

  end
end