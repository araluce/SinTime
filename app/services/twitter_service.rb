class TwitterService
  CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key        = 'wNhHfRrCJiKqtpGKNoESzZf10'
    config.consumer_secret     = 'UFrFsCIIMwRZK5KVGAfUBAb5VY53EuXmdTReirOGyi6uFJZ0vn'
    config.access_token        = '743191767164592129-ZQwH3OpEmZ7lji1Lo7xGNd9cJGzbI5x'
    config.access_token_secret = 'Im8zcvNeTUQvCLuCp7PR9dPNE2GZCiISt7qLXReZ3Fd8Y'
  end

  class << self

    def search_tweet(id)
      CLIENT.search(id)
    end

    def get_latest_tweet_by_user(user)
      result = []
      num_tweets = Constant.find_by_key('número de tweets a cargar en seguimiento').value.to_i rescue 25
      CLIENT.user_timeline(user, count: num_tweets, exclude_replies: true, include_rts: false).each do |tweet|
        result << tweet
      end
      result
    end

    def get_latest_tweet_by_hashtags(hashtags)
      result = []
      hashtags.each do |hashtag|
        CLIENT.search(hashtag).each do |tweet|
          result << tweet
        end
      end
      result
    end

    def get_tweet_by_id(id)
      CLIENT.status(id)
    end

    def uri_normalize(uri)
      "#{uri.scheme}://#{uri.host}#{uri.path}" rescue ''
    end

  end

end