class Exercise::Sport < Exercise

  validates :cycling_rate,
            :hours_cycling,
            :minutes_cycling,
            :seconds_cycling,
            :running_rate,
            :hours_running,
            :minutes_running,
            :seconds_running,
            numericality: {greater_than: 0, allow_nil: false, allow_blank: false}

  def phase
    statement
  end
end
