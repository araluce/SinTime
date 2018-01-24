class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :ariaexpanded, :collapsed, :show_secction

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
end
