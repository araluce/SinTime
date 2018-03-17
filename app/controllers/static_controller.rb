class StaticController < ApplicationController
  def home
  end

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

  def tweets
    @sintime_tweets = TwitterService.get_latest_tweet_by_hashtags(['#ProyectoSinTime', '#proyectosintime'])
  end

  def register
    @user = user_model.new
  end

  def check_register
    @user = user_model.find_by(dni: params[:user][:dni])
    if @user
      unless @user.alias.blank?
        flash[:notice] = 'Este usuario ya se ha registrado'
        redirect_to root_path
      else
        flash[:notice] = 'Usuario inscrito'
      end
    else
      flash[:notice] = 'Usuario no dado de alta, por favor, contacte con su profesor'
      redirect_to action: :register
    end
  end

  def register_user
    @user = user_model.find_by(dni: params[:user][:dni])
    if @user.update(user_params)
      flash[:notice] = 'Perfil actualizado correctamente'
      redirect_to root_path
    else
      @errors = @user.errors
      render :check_register
    end
  end

  private

  def user_model
    User
  end

  def user_params
    params.require(:user).permit(
        :dni,
        :alias,
        :avatar,
        :name,
        :lastname,
        :dob,
        :password,
        :password_confirmation,
        :email
    )
  end

end