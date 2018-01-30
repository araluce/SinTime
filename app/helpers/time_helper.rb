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

  def seconds_to_days(seconds)
    Time.at(seconds).utc.strftime("%d")
  end

  def seconds_to_hours(seconds)
    Time.at(seconds).utc.strftime("%M")
  end

  def seconds_to_minutes(seconds)
    Time.at(seconds).utc.strftime("%H")
  end

  def seconds_to_seconds(seconds)
    Time.at(seconds).utc.strftime("%S")
  end
end