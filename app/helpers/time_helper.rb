module TimeHelper
  def days_to_seconds(days)
    days * 24 * 60 * 60 rescue 0
  end

  def hours_to_seconds(hours)
    hours * 60 * 60 rescue 0
  end

  def minutes_to_seconds(minutes)
    minutes * 60 rescue 0
  end

  def days_per_seconds(seconds)
    (seconds / 60 / 60 / 24) % 10
  end

  def days_per_minutes(minutes)
    (minutes / 60 / 24) % 10
  end

  def days_per_hours(hours)
    (hours / 24) % 10
  end
end