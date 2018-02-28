class Constant < ApplicationRecord
  validates :key,
            :value,
            presence: true

  def to_s
    key
  end
end
