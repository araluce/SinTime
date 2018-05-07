class LevelMailer < ApplicationMailer
  layout 'no_reply_mail'

  def resume(user, date)
    @user = user
    @date = date
    mail(to: user.email, subject: "SinTime - Tu nivel y XP") if user.email
  end
end