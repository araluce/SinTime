class BetOptionUser < ApplicationRecord
  include TimeHelper

  belongs_to :user, class_name: 'User', inverse_of: :bet_option_user
  belongs_to :bet_option, class_name: 'BetOption', inverse_of: :bet_users

  delegate :right_option, to: :bet_option

  before_save :set_time_wagered

  attr_accessor :days_bet,
                :hours_bet,
                :minutes_bet,
                :seconds_bet

  validates :days_bet,
            :hours_bet,
            :minutes_bet,
            :seconds_bet,
            numericality: {allow_nil: false, allow_blank: false}

  def to_s
    "@#{user.alias} ha apostado #{seconds_to_s(time_wagered)}"
  end

  def set_time_wagered
    self.time_wagered = days_to_seconds(days_bet.to_f) + hours_to_seconds(hours_bet.to_f) + minutes_to_seconds(minutes_bet.to_f) + seconds_bet.to_f
  end
end
