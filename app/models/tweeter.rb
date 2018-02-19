class Tweeter < ApplicationRecord

  has_and_belongs_to_many :users, class_name: 'User'

  validates :tweeter, uniqueness: true
  validates :tweeter, presence: true

  def to_s
    tweeter
  end

end
