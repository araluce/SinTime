class RuntasticService
  class << self

    def model
      Exercise::Sport
    end

    def current_sport(date)
      sport_date = model.where('created_at < ?', date).order(:created_at).last.created_at rescue model.minimum(:created_at)
      model.find_by(created_at: sport_date)
    end

    def current_speed(date)
      current_sport(date).speed rescue nil
    end

    def current_pace(date)
      current_sport(date).pace rescue nil
    end

    def current_time_running(date)
      current_sport(date).time_running rescue nil
    end

    def current_time_cycling(date)
      current_sport(date).time_cycling rescue nil
    end

    def pace_pass?(session, date)
      pace = current_pace(date)
      return false if pace.nil?

      session.pace <= pace
    end

    def speed_pass?(session, date)
      speed = current_speed(date)
      return false if speed.nil?

      session.average_speed >= speed
    end

    def running_candidates_pass?(candidates, date)
      exercise_duration = current_time_running(date)
      return false if exercise_duration.nil?

      duration_accumulated = 0

      candidates.each do |candidate|
        duration_accumulated += candidate.avg_duration
      end

      duration_accumulated >= exercise_duration
    end

    def cycling_candidates_pass?(candidates, date)
      exercise_duration = current_time_cycling(date)
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
        puts "Fallo al descargar los datos del usuario #{user.alias} con id #{user.id}"
      end

      min_created_at = Date.today.beginning_of_week - 1.week

      running_candidates = []
      user.user_runtastic.activity_logs.last_week.running.each do |session|
        running_candidates << session if pace_pass?(session, min_created_at)
      end

      cycling_candidates = []
      user.user_runtastic.activity_logs.last_week.not_running.each do |session|
        cycling_candidates << session if speed_pass?(session, min_created_at)
      end

      if (running_candidates_pass?(running_candidates, min_created_at) && running_candidates.count > 2) ||
          (cycling_candidates_pass?(cycling_candidates, min_created_at) && cycling_candidates.count > 2)
          PayService.pay_sport(user, current_sport(min_created_at))
          PayService.pay_sport(user, current_sport(min_created_at)) if user.user_privileges_cards.where(privileges_card: PrivilegesCard.find_by_identifier(7), created_at: (DateTime.now-1.week)..(DateTime.now)).any?
      end

      RuntasticMailer.resume(user).deliver_now

    end

    def evalue_user_sport_last(user)
      return nil if user.user_runtastic.nil?

      begin
        user.user_runtastic.perform
      rescue
        puts "Fallo al descargar los datos del usuario #{user.alias} con id #{user.id}"
      end

      min_created_at = Date.today.beginning_of_week - 2.week

      running_candidates = []
      user.user_runtastic.activity_logs.last_last_week.running.each do |session|
        running_candidates << session if pace_pass?(session, min_created_at)
      end

      cycling_candidates = []
      user.user_runtastic.activity_logs.last_last_week.not_running.each do |session|
        cycling_candidates << session if speed_pass?(session, min_created_at)
      end

      if (running_candidates_pass?(running_candidates, min_created_at) && running_candidates.count > 2) ||
          (cycling_candidates_pass?(cycling_candidates, min_created_at) && cycling_candidates.count > 2)
        PayService.pay_sport(user, current_sport(min_created_at))
        PayService.pay_sport(user, current_sport(min_created_at)) if user.user_privileges_cards.where(privileges_card: PrivilegesCard.find_by_identifier(7), created_at: (DateTime.now-1.week)..(DateTime.now)).any?
      end

      RuntasticMailer.resume(user).deliver_now

    end

    def user_pass_sport(user)
      return false if user.user_runtastic.nil?

      begin
        user.user_runtastic.perform
      rescue
        put "Fallo al descargar los datos del usuario #{user.alias} con id #{user.id}"
      end
      min_created_at = Date.today.beginning_of_week - 1.week

      running_candidates = []
      user.user_runtastic.activity_logs.last_week.running.each do |session|
        running_candidates << session if pace_pass?(session, min_created_at)
      end

      cycling_candidates = []
      user.user_runtastic.activity_logs.last_week.not_running.each do |session|
        cycling_candidates << session if speed_pass?(session, min_created_at)
      end

      if (running_candidates_pass?(running_candidates, min_created_at) && running_candidates.count > 2) ||
          (cycling_candidates_pass?(cycling_candidates, min_created_at) && cycling_candidates.count > 2)
        return true
      end

      false
    end

    def user_pass_sport_week(user, week)
      return false if user.user_runtastic.nil?

      begin
        user.user_runtastic.perform
      rescue
        # put "Fallo al descargar los datos del usuario #{user.alias} con id #{user.id}"
      end

      min_created_at = Date.today.beginning_of_day - week.week

      running_candidates = []
      user.user_runtastic.activity_logs.where(date: (Date.today.beginning_of_week- week.week)..(Date.today.end_of_week- week.week)).running.each do |session|
        running_candidates << session if pace_pass?(session, min_created_at)
      end

      cycling_candidates = []
      user.user_runtastic.activity_logs.where(date: (Date.today.beginning_of_week- week.week)..(Date.today.end_of_week- week.week)).not_running.each do |session|
        cycling_candidates << session if speed_pass?(session, min_created_at)
      end

      if (running_candidates_pass?(running_candidates, min_created_at) && running_candidates.count > 2) ||
          (cycling_candidates_pass?(cycling_candidates, min_created_at) && cycling_candidates.count > 2)
        return true
      end

      false
    end

    def user_pass_sport_date(user, date)
      return false if user.user_runtastic.nil?

      min_created_at = date.beginning_of_week

      running_candidates = []
      user.user_runtastic.activity_logs.where(date: date.beginning_of_week..date.end_of_week).running.each do |session|
        running_candidates << session if pace_pass?(session, min_created_at)
      end

      cycling_candidates = []
      user.user_runtastic.activity_logs.where(date: date.beginning_of_week..date.end_of_week).not_running.each do |session|
        cycling_candidates << session if speed_pass?(session, min_created_at)
      end

      if (running_candidates_pass?(running_candidates, min_created_at) && running_candidates.count > 2) ||
          (cycling_candidates_pass?(cycling_candidates, min_created_at) && cycling_candidates.count > 2)
        return true
      end

      false
    end
  end
end