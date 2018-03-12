class ActivityLog < ApplicationRecord
  belongs_to :user_runtastic, inverse_of: :activity_logs
  belongs_to :exercise_sport, class_name: 'Exercise::Sport', inverse_of: :activity_logs, optional: true

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
    number_with_precision(avg_duration_to_minutes.to_f/avg_distance_to_kms.to_f, precision: 2) rescue 0
  end

  def avg_duration_to_minutes
    duration.to_f/1000/60
  end

  def avg_distance_to_kms
    distance.to_f/1000
  end

end
