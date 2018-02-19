class Tweet < ApplicationRecord
  has_many :backpacks, class_name: '::Twitter::Backpack', inverse_of: :tweet ,dependent: :destroy
  has_many :users, class_name: '::User', through: :backpacks, inverse_of: :tweets

  validates :tweet_id, uniqueness: true
  validates :tweet_id, presence: true

  def to_s
    tweet_id
  end
end