module Manager
  class DistrictsController < ApplicationController
    layout 'manager'

    before_action :set_object, only: [:show, :update, :destroy, :edit]
    before_action :authenticate_admin!
    before_action :load_resource_name
    before_action :set_open_section

    def model
      District
    end

    def load_resource_name
      @resource_name = 'District'
    end

    def set_open_section
      @open_section = 'General'
    end

    def object_initialization
    end

    def index
      @objects = model.order(created_at: :desc).page(params[:page])
    end

    def show
    end

    def new
      @object = model.new
    end

    def create
      @object = model.new(object_params)

      if @object.save
        redirect_to manager_district_path(@object), notice: 'Distrito creado correctamente'
      else
        object_initialization
        render :new
      end
    end

    def edit
    end

    def update
      if @object.update(object_params)
        redirect_to manager_district_path, notice: 'Distrito actualizado correctamente'
      else
        object_initialization
        render :edit
      end
    end

    def destroy
      @object.destroy
      respond_to do |format|
        format.html {redirect_to manager_districts_path, notice: 'Distrito eliminado correctamente'}
        format.json {head :no_content}
      end
    end

    private

    def clinic_params
      params.require(:clinic).permit(
          :name,
          user_ids: []
      )
    end

    def set_object
      @object = model.find_by_id(params[:id])
    end

  end
end