class StaticController < ApplicationController
  def home
  end

  def tweets
    @sintime_tweets = TwitterService.get_latest_tweet_by_hashtags(['#ProyectoSinTime', '#proyectosintime'])
  end

end