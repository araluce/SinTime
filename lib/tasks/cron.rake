namespace :cron do
  desc 'Cron tasks'

  task twitter: :environment do
    benefit = Constant.find_by_key('recompensa tweets').value.to_i
    min_tweets = Constant.find_by_key('máximos tuits diarios').value.to_i

    p "=================TWITTER (#{DateTime.now})===================="

    User.find_each do |user|
      if user.yesterday_tweets_count >= min_tweets
        PayService.system_pay_reason(user, benefit, 'Pago por seguimiento')
        p "Se han pagado #{benefit} segundos a #{user.alias} ##{user.id}"
      end
    end

    puts "#{Time.now} - Success!"
  end

  task runtastic: :environment do
    p "=================Runtastic (#{DateTime.now})===================="

    User.find_each do |user|
      RuntasticService.evalue_user_sport(user)
    end


    puts "#{Time.now} - Success!"
  end

  task level: :environment do
    p "=================Levels (#{DateTime.now})===================="
    User.find_each do |user|
      if ScoresServices.has_max_score_last_week?(user)
        if RuntasticService.user_pass_sport(user)
          LevelService.level_up(user)
          p "El usuario #{user} (##{user.id}) ha subido de nivel (#{user.xp}XP)"
        end
      end
      LevelMailer.resume(user).deliver_now
    end
    puts "#{Time.now} - Success!"
  end

  task users_ranking_month: :environment do
    p "=================User Ranking (#{DateTime.now})===================="
    RankingService.users_ranking
    puts "#{Time.now} - Success!"
  end

  task districts_ranking_month: :environment do
    p "=================District Ranking (#{DateTime.now})===================="
    RankingService.districts_ranking
    puts "#{Time.now} - Success!"
  end

  task pay_share: :environment do
    p "=================Shareds (#{DateTime.now})===================="
    Loan.open.find_each do |loan|
      LoanService.pay_share(loan)
      p "@#{loan.user.alias.downcase} ha pagado una cuota de #{loan.time_per_share}"
    end
    puts "#{Time.now} - Success!"
  end

  task night_break: :environment do
    p "=================Night Break (#{DateTime.now})===================="
    CardService.night_break_perform
    puts "#{Time.now} - Success!"
  end

end
