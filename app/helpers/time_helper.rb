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
    (seconds / 86400).to_s.rjust(2,'0')
  end

  def seconds_to_hours(seconds)
    (seconds / 3600 % 24).to_s.rjust(2,'0')
  end

  def seconds_to_minutes(seconds)
   (seconds / 60 % 60).to_s.rjust(2,'0')
  end

  def seconds_to_seconds(seconds)
    (seconds % 60).to_s.rjust(2,'0')
  end

  def seconds_to_s(seconds)
    ["#{seconds_to_days(seconds)}D", "#{seconds_to_hours(seconds)}H", "#{seconds_to_minutes(seconds)}M", "#{seconds_to_seconds(seconds)}S"].join(' ')
  end
end