class BankingMovement < ApplicationRecord
  belongs_to :user, inverse_of: :banking_movements
  belongs_to :exercise, inverse_of: :banking_movements, optional: true

  validates :time_before,
            :time_after,
            :reason,
            presence: true

  def seconds_difference
    time_after - time_before
  end

  def is_positive?
    time_before < time_after
  end
end
