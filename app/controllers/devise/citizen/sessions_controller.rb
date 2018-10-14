class Devise::Citizen::SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    super
    if resource.inactive?
      resource.update_attributes!(status: 'Vivo')
    end
    resource.update_attributes!(logged: true)
  end

  def destroy
    current_user.update_attributes!(logged: false) unless current_user.nil?
    super
  end

end