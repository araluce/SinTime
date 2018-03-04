class ActivityLog < ApplicationRecord
  belongs_to :user_runtastic, inverse_of: :activity_logs

  enum activity_type: %w(running racecycling cycling mountainbiking), _prefix: true

  activity_types.each do |activity_type, index|
    scope activity_type.to_sym, -> { where(activity_type: activity_type) }
    scope "not_#{activity_type.to_sym}", -> { where.not(activity_type: activity_type) }

    define_method "is_#{activity_type}?" do
      self.activity_type == activity_type
    end
  end

  scope :week, -> { where(date: Date.today.beginning_of_week..Date.today.end_of_week) }
  scope :last_week, -> { where(date: (Date.today.beginning_of_week-1.week)..(Date.today.end_of_week-1.week)) }

  def is_this_week?
    self.date >=  Date.today.beginning_of_week && self.date <= Date.today.end_of_week
  end

  def is_last_week?
    self.date >=  (Date.today.beginning_of_week-1.week) && self.date <= (Date.today.end_of_week-1.week)
  end

  def pace
    avg_duration_to_minutes/avg_distance_to_kms
  end

  def avg_duration_to_minutes
    duration/1000/60
  end

  def avg_distance_to_kms
    distance/1000
  end

end
