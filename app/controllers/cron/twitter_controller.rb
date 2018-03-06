module Cron
  class TwitterController < ApplicationController

    def twitter_count
      benefit = Constant.find_by_key('recompensa tweets').value.to_i
      min_tweets = Constant.find_by_key('máximos tuits diarios').value.to_i

      User.find_each do |user|
        PayService.pay_reason(user, benefit, 'Pago por seguimiento') if user.yesterday_tweets_count >= min_tweets
      end
    end

  end
end