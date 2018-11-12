class Exercise::Audience < Exercise

  scope :clan, -> { where(district: true) }
  scope :individual, -> { where(district: false) }

  validates :title,
            :icon,
            presence: true

  def to_s
    title
  end

  def type_to_s
    'Audiencia'
  end

  def is_individual?
    !district
  end

  def is_clan?
    district
  end

  def set_time_benefit
    self.time_benefit = 0
  end

  def check_time

  end
end
