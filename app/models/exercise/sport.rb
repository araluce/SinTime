class Exercise::Sport < Exercise
  include TimeHelper
  before_save :set_running_duration
  before_save :set_cycling_duration

  has_many :activity_logs, inverse_of: :exercise_sport

  attr_accessor :days_running,
                :hours_running,
                :minutes_running,
                :seconds_running,
                :days_cycling,
                :hours_cycling,
                :minutes_cycling,
                :seconds_cycling

  validates :pace,
            :speed,
            numericality: {greater_than_: 0, allow_blank: false, allow_nil: false}
  validates :days_running,
            :hours_running,
            :minutes_running,
            :seconds_running,
            :days_cycling,
            :hours_cycling,
            :minutes_cycling,
            :seconds_cycling,
            numericality: {allow_nil: false, allow_blank: false}

  validate :check_running_time
  validate :check_cycling_time

  def phase
    statement
  end

  def type_to_s
    'Sport'
  end

  private

  def set_running_duration
    set_duration('running')
  end

  def set_clycling_duration
    set_duration('cycling')
  end

  def set_duration(suffix)
    self.send("time_#{suffix}=", days_to_seconds(send("days_#{suffix}").to_f) + hours_to_seconds(send("hours_#{suffix}").to_f) + minutes_to_seconds(send("minutes_#{suffix}").to_f) + send("seconds_#{suffix}").to_f)
  end

  def check_running_time
    check_sport_time('running')
  end

  def check_cycling_time
    check_sport_time('cycling')
  end

  def check_sport_time(suffix)
    unless set_duration(suffix) > 0
      errors.add("days_#{suffix}".to_sym, 'El tiempo debe ser mayor que 0')
      errors.add("hours_#{suffix}".to_sym, 'El tiempo debe ser mayor que 0')
      errors.add("minutes_#{suffix}".to_sym, 'El tiempo debe ser mayor que 0')
      errors.add("seconds_#{suffix}".to_sym, 'El tiempo debe ser mayor que 0')
    end
  end

end
