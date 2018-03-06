module Padawan
  module Formacion
    class SeguimientoController < Padawan::FormacionController
      layout 'padawan'
      include TwitterHelper

      before_action :load_tweeters, only: [:follow_user, :twitter, :seguimiento, :load_tweeter_tweets, :mochila]

      def seguimiento
        object_initialization
        @tweets = []
        if current_user.tweeters.any?
          @tweets = TwitterService.get_latest_tweet_by_user(current_user.tweeters.first&.to_s)
          check_private_profile
        end
      end

      def load_tweeter_tweets
        object_initialization
        _tweeter = Tweeter.find( params[:user][:tweeter_ids])

        if _tweeter
          @tweets = TwitterService.get_latest_tweet_by_user(_tweeter.to_s)
          check_private_profile
        else
          @tweets = TwitterService.get_latest_tweet_by_user(current_user.tweeters.first&.to_s)
          check_private_profile
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
          object_initialization

          if @tweets_count < @max_tweets_per_day
            @tweet = Tweet.find_or_create_by(tweet_id: params[:tweet_id])

            if type == 'compartido'
              redirect_to action: :seguimiento
            else
              save_tweet(type, @tweet)
              redirect_to action: :seguimiento
            end
          else
            flash[:notice] = "Sólo se permiten un máximo de #{@max_tweets_per_day} tweets diarios"
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
          check_private_profile
        else
          @errors = @tweeter.errors
        end

        object_initialization

        render :seguimiento

      end

      private

      def check_private_profile
        case @tweets
          when 1
            flash[:notice] = 'Este perfil es privado'
            @tweets = []
          when 2
            flash[:notice] = 'Perfil no encontrado'
            @tweets = []
        end
      end

      def object_initialization
        @tweeter = Tweeter.new()
        @max_tweets_per_day = Constant.find_by_key('maximos tuits diarios').value.to_i
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