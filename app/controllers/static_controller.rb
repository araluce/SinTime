class StaticController < ApplicationController

  def home
  end

  def tweets
    @nazaries_tweets_tweets = TwitterService.get_latest_tweet_tweet('araluce1')
  end

end