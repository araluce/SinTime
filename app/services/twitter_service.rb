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
      begin
        result = []
        num_tweets = Constant.find_by_key('número de tweets a cargar en seguimiento').value.to_i rescue 25
        CLIENT.user_timeline(user, count: num_tweets, exclude_replies: true).each do |tweet|
          result << tweet
        end
        result
      rescue Twitter::Error::Unauthorized => e
        1
      rescue Twitter::Error::NotFound=> e
        2
      end
    end

    def get_latest_tweet_by_hashtags(hashtags)
      result = []
      options = {count: 200, include_rts: true}
      hashtags.each do |hashtag|
        CLIENT.search(hashtag, options).each do |tweet|
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

    def collect_with_max_id(collection=[], max_id=nil, &block)
      response = yield(max_id)
      collection += response
      response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
    end

    def get_all_tweets(user)
      collect_with_max_id do |max_id|
        options = {count: 200, include_rts: true}
        options[:max_id] = max_id unless max_id.nil?
        CLIENT.user_timeline(user, options)
      end
    end

    def get_all_tweets_hashtag(hashtag)
      collect_with_max_id do |max_id|
        options = {count: 200}
        options[:max_id] = max_id unless max_id.nil?
        CLIENT.search(hashtag, options)
      end
    end

    def get_all_tweets_hashtags(hashtags)
      binding.pry
    end

  end

end