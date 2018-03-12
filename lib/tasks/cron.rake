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

end
