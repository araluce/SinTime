class Loan < ApplicationRecord
  include TimeHelper

  before_create :set_time_loan
  before_create :set_share_remaining

  belongs_to :user, class_name: 'User', inverse_of: :loans

  scope :closed, -> { where(share_remaining: 0) }
  scope :open, -> { where.not(id: nil, share_remaining: 0) }

  attr_accessor :days_loan,
                :hours_loan,
                :minutes_loan,
                :seconds_loan

  validates :days_loan,
            :hours_loan,
            :minutes_loan,
            :seconds_loan,
            numericality: {allow_nil: false, allow_blank: false, only_integer: true}

  validates :days_loan, numericality: {less_than_or_equal_to: 7}

  validates :share, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 4, only_integer: true}
  validate :check_time
  validate :check_open_loads

  def to_s
    "Préstamo de #{seconds_to_s(time_loan)}. Restante #{seconds_to_s(time_remaining)}"
  end

  def time_per_share
    time_loan / share
  end

  def is_open?
    return false if new_record?
    share_remaining > 0
  end

  def is_closed?
    return true if new_record?
    share_remaining == 0
  end

  private

  def set_time_loan
    self.time_loan = days_to_seconds(days_loan.to_f) + hours_to_seconds(hours_loan.to_f) + minutes_to_seconds(minutes_loan.to_f) + seconds_loan.to_f
    self.time_remaining = time_loan
  end

  def set_share_remaining
    self.share_remaining = share
  end

  def check_time
    unless set_time_loan > 0
      errors.add(:days_loan, 'El tiempo solicitado debe ser mayor que 0')
      errors.add(:hours_loan, 'El tiempo solicitado debe ser mayor que 0')
      errors.add(:minutes_loan, 'El tiempo solicitado debe ser mayor que 0')
      errors.add(:seconds_loan, 'El tiempo solicitado debe ser mayor que 0')
    end
  end

  def check_open_loads
    errors.add(:share, 'No puedes solicitar más de un préstamo al mismo tiempo') if user.loans.open.count > 0
  end

  def applicable_interest

  end
end
