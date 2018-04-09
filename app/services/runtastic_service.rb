class RuntasticService
  class << self

    def current_sport
      Exercise::Sport.all.last
    end

    def current_speed
      current_sport.speed rescue nil
    end

    def current_pace
      current_sport.pace rescue nil
    end

    def current_time_running
      current_sport.time_running rescue nil
    end

    def current_time_cycling
      current_sport.time_cycling rescue nil
    end

    def pace_pass?(session)
      pace = current_pace
      return false if pace.nil?

      session.pace <= pace
    end

    def speed_pass?(session)
      speed = current_speed
      return false if speed.nil?

      session.average_speed >= speed
    end

    def running_candidates_pass?(candidates)
      exercise_duration = current_time_running
      return false if exercise_duration.nil?

      duration_accumulated = 0

      candidates.each do |candidate|
        duration_accumulated += candidate.avg_duration
      end

      duration_accumulated >= exercise_duration
    end

    def cycling_candidates_pass?(candidates)
      exercise_duration = current_time_cycling
      return false if exercise_duration.nil?

      duration_accumulated = 0

      candidates.each do |candidate|
        duration_accumulated += candidate.avg_duration
      end

      duration_accumulated >= exercise_duration
    end

    def evalue_user_sport(user)
      return nil if user.user_runtastic.nil?

      begin
        user.user_runtastic.perform
      rescue
        put "Fallo al descargar los datos del usuario #{user.alias} con id #{user.id}"
      end

      running_candidates = []
      user.user_runtastic.activity_logs.last_week.running.each do |session|
        running_candidates << session if pace_pass?(session)
      end

      cycling_candidates = []
      user.user_runtastic.activity_logs.last_week.not_running.each do |session|
        cycling_candidates << session if speed_pass?(session)
      end

      if (running_candidates_pass?(running_candidates) && running_candidates.count > 2) ||
          (cycling_candidates_pass?(cycling_candidates) && cycling_candidates.count > 2)
          PayService.pay_sport(user, current_sport)
      end

      RuntasticMailer.resume(user).deliver_now

    end

    def evalue_user_sport_last(user)
      return nil if user.user_runtastic.nil?

      begin
        user.user_runtastic.perform
      rescue
        put "Fallo al descargar los datos del usuario #{user.alias} con id #{user.id}"
      end

      running_candidates = []
      user.user_runtastic.activity_logs.last_last_week.running.each do |session|
        running_candidates << session if pace_pass?(session)
      end

      cycling_candidates = []
      user.user_runtastic.activity_logs.last_last_week.not_running.each do |session|
        cycling_candidates << session if speed_pass?(session)
      end

      if (running_candidates_pass?(running_candidates) && running_candidates.count > 2) ||
          (cycling_candidates_pass?(cycling_candidates) && cycling_candidates.count > 2)
        PayService.pay_sport(user, current_sport)
      end

      RuntasticMailer.resume(user).deliver_now

    end

    def user_pass_sport(user)
      return nil if user.user_runtastic.nil?

      begin
        user.user_runtastic.perform
      rescue
        put "Fallo al descargar los datos del usuario #{user.alias} con id #{user.id}"
      end

      running_candidates = []
      user.user_runtastic.activity_logs.last_week.running.each do |session|
        running_candidates << session if pace_pass?(session)
      end

      cycling_candidates = []
      user.user_runtastic.activity_logs.last_week.not_running.each do |session|
        cycling_candidates << session if speed_pass?(session)
      end

      if (running_candidates_pass?(running_candidates) && running_candidates.count > 2) ||
          (cycling_candidates_pass?(cycling_candidates) && cycling_candidates.count > 2)
        return true
      end

      false
    end
  end
end