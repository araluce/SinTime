module Manager
  class ConstantsController < ApplicationController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :set_objects, except: [:new, :show, :edit, :update]
    before_action :authenticate_admin!
    before_action :load_resource_name
    before_action :set_open_section

    def model
      Constant
    end

    def load_resource_name
      @resource_name = 'Constantes'
    end

    def set_open_section
      @open_section = 'General'
    end

    def index
      @object = model.new
    end

    def new
      @object = model.new
    end

    def create
      @object = model.new(object_params)

      if @object.save
        redirect_to manager_constants_path, notice: 'Constante creada correctamente'
      else
        render :index
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_constants_path, notice: 'Constante actualizada correctamente'
      else
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_constants_path, notice: 'Constante eliminada correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def object_params
      params.require(:constant).permit(
          :key,
          :value
      )
    end

    def set_object
      @object = model.find(params[:id])
    end

    def set_objects
      @objects = model.order(created_at: :desc)
    end

  end
end