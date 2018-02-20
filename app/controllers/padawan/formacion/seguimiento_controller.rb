module Padawan
  module Formacion
    class SeguimientoController < Padawan::FormacionController
      include TwitterHelper

      before_action :load_tweeters, only: [:follow_user, :twitter, :seguimiento, :load_tweeter_tweets, :mochila]

      def seguimiento
        object_initialization
        @tweets = []
        @tweets = TwitterService.get_latest_tweet_by_user(current_user.tweeters.first&.to_s) if current_user.tweeters.any?
      end

      def load_tweeter_tweets
        object_initialization
        _tweeter = Tweeter.find( params[:user][:tweeter_ids])

        if _tweeter
          @tweets = TwitterService.get_latest_tweet_by_user(_tweeter.to_s)
        else
          @tweets = TwitterService.get_latest_tweet_by_user(current_user.tweeters.first&.to_s)
        end

        render 'seguimiento'
      end

      def mochila
        object_initialization
        @tweets = []
        current_user.backpacks.where(backpack_type: params[:backpack_type]).map {|backpack| @tweets << TwitterService.get_tweet_by_id(backpack.tweet.tweet_id)}
        render :seguimiento
      end

      Twitter::Backpack.backpack_types.each do |type, index|
        define_method "guardar_#{type.downcase.gsub(' ', '_')}" do
          @tweet = Tweet.find_or_create_by(tweet_id: params[:tweet_id])

          if type == 'compartido'
            redirect_to action: :seguimiento
          else
            save_tweet(type, @tweet)
            redirect_to action: :seguimiento
          end
        end
      end

      def follow_user
        tweeter_param = params[:tweeter][:tweeter].gsub(' ', '_').remove('@')
        @tweeter = Tweeter.find_or_create_by(tweeter: tweeter_param)

        if @tweeter.valid?
          tweeters = current_user.tweeters
          tweeters = current_user.tweeters + [@tweeter] unless current_user.tweeters.include? @tweeter

          current_user.update_attributes(tweeters: tweeters)
          flash[:notice] = "Ahora estás siguiendo a #{@tweeter}"
          @tweets = TwitterService.get_latest_tweet_by_user(@tweeter.to_s)
        else
          @errors = @tweeter.errors
        end

        render :seguimiento

      end

      private

      def object_initialization
        @tweeter = Tweeter.new()
        @tweets_count = current_user.backpacks.where('updated_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).count
      end

      def follow_user_params
        params.require(:tweeter).permit(
            :tweeter,
        ).merge(user: current_user)
      end

      def load_tweeters
        @tweeters = current_user.tweets_count
      end

    end
  end
end