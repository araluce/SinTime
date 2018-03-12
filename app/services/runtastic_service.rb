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
        duration_accumulated += candidate.first
      end

      duration_accumulated >= exercise_duration
    end

    def cycling_candidates_pass?(candidates)
      exercise_duration = current_time_cycling
      return false if exercise_duration.nil?

      duration_accumulated = 0

      candidates.each do |candidate|
        duration_accumulated += candidate.first
      end

      duration_accumulated >= exercise_duration
    end

    def evalue_user_sport(user)
      return nil if user.user_runtastic.nil?

      begin
        user.user_runtastic.perform
      rescue
        p "Fallo al descargar los datos del usuario #{user.alias} con id #{user.id}"
      end

      running_sessions = user.user_runtastic.activity_logs.last_week.running.map{|activity| [activity.duration.to_f/1000, activity.pace]}
      cycling_sessions = user.user_runtastic.activity_logs.last_week.not_running.map{|activity| [activity.duration.to_f/1000, activity.average_speed]}

      running_candidates =
      cycling_candidates = []

      running_sessions.each do |session|
        running_candidates << session if session.second <= current_pace
      end

      cycling_sessions.each do |session|
        cycling_candidates << session if session.second >= current_speed
      end

      if (running_candidates_pass?(running_candidates) && running_candidates.count > 3) ||
          (cycling_candidates_pass?(cycling_candidates) && cycling_candidates.count > 3)
          PayService.pay_sport(user, current_sport)
      end

    end
  end
end