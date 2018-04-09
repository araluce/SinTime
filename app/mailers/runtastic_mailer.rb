class RuntasticMailer < ApplicationMailer
  layout 'no_reply_mail'

  def resume(user)
    running_candidates = []
    @running_sessions = []
    user.user_runtastic.activity_logs.last_week.running.each do |session|
      running_candidates << session if RuntasticService.pace_pass?(session)
      @running_sessions << session
    end

    cycling_candidates = []
    @cycling_sessions = []
    user.user_runtastic.activity_logs.last_week.not_running.each do |session|
      cycling_candidates << session if RuntasticService.speed_pass?(session)
      @cycling_sessions << session
    end

    @pass = false

    if (RuntasticService.running_candidates_pass?(running_candidates) && running_candidates.count > 2) ||
        (RuntasticService.cycling_candidates_pass?(cycling_candidates) && cycling_candidates.count > 2)
      @pass = true
    end
    mail(to: user.email, subject: "SinTime - Tu resumen deportivo de la semana") if user.email
  end
end