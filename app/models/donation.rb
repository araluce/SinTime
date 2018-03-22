class Donation < ApplicationRecord
  include TimeHelper

  belongs_to :sender, class_name: 'User', inverse_of: :donations_sent
  belongs_to :receiver, class_name: 'User', inverse_of: :donations_receiver

  validates :seconds_donated, numericality: { only_integer: true, greater_than: 0, less_than: 604800 }
  validates :receiver_id, uniqueness: { scope: :sender_id }

  attr_accessor :days, :hours, :minutes, :seconds

  def to_s
    "@#{sender.alias.downcase} ha enviado una donación de #{seconds_to_s(seconds_donated)} a @#{receiver.alias.downcase}"
  end

end
