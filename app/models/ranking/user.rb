class Ranking::User < Ranking
  belongs_to :user, class_name: '::User', inverse_of: :ranking_users

  def to_s
    position
  end
end