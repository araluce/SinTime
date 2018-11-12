class RuntasticMailer < ApplicationMailer
  layout 'no_reply_mail'

  def resume(user, date)
    running_candidates = []
    @running_sessions = []
    user.user_runtastic.activity_logs.last_week.running.each do |session|
      running_candidates << session if RuntasticService.pace_pass?(session, date)
      @running_sessions << session
    end

    cycling_candidates = []
    @cycling_sessions = []
    user.user_runtastic.activity_logs.last_week.not_running.each do |session|
      cycling_candidates << session if RuntasticService.speed_pass?(session, date)
      @cycling_sessions << session
    end

    @pass = false

    if (RuntasticService.running_candidates_pass?(running_candidates, date) && running_candidates.count > 2) ||
        (RuntasticService.cycling_candidates_pass?(cycling_candidates, date) && cycling_candidates.count > 2)
      @pass = true
    end
    mail(to: user.email, subject: "SinTime - Tu resumen deportivo de la semana") if user.email
  end
end