class Exercise < ApplicationRecord

  validates :statement, presence: true

  def to_s
    statement
  end
end
