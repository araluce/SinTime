module TwitterHelper

  def save_tweet(type, tweet)
    if current_user.tweets.include? tweet
      backpack = current_user.backpacks.find_by(tweet: tweet)
      flash[:notice] = "Tweet cambiado de la mochila #{backpack.backpack_type} a la mochila #{type}"
      @error = "Tweet cambiado de la mochila #{backpack.backpack_type} a la mochila #{type}"
    else
      backpack = current_user.backpacks.create(tweet: tweet)
      flash[:notice] = "Tweet agregado correctamente a la mochila #{type}"
      @error = "Tweet agregado correctamente a la mochila #{type}"
    end
    backpack.update_columns(backpack_type: type)
  end

  def share_tweet(users_to_share, tweet)

  end

end