class StaticController < ApplicationController

  def home
  end

  def tweets
    @nazaries_tweets = TwitterService.get_latest_tweet('nazaries')
  end

end