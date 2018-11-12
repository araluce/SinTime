class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :ariaexpanded, :collapsed, :show_secction, :section_active_class

  private

  def ariaexpanded(section)
    @open_section == section
  end

  def collapsed(section)
    'collapsed' if @open_section != section
  end

  def show_secction(section)
    'show' if @open_section == section
  end

  def section_active_class(section)
    'active' if @resource_name == section
  end
end
