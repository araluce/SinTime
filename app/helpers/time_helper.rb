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

  def break_down_time(time_in_seconds)
    integer_time_in_seconds = time_in_seconds.to_i
    {
        days: seconds_to_days(integer_time_in_seconds).to_i,
        hours: seconds_to_hours(integer_time_in_seconds).to_i,
        minutes: seconds_to_minutes(integer_time_in_seconds).to_i,
        seconds: seconds_to_seconds(integer_time_in_seconds).to_i
    }
  end

  def seconds_to_duration(time_in_seconds)
    time_break = break_down_time(time_in_seconds)
    time_break[:days].days + time_break[:hours].hours + time_break[:minutes].minutes + time_break[:seconds].seconds
  end

  def datetime_to_seconds(time)
    if time.class.name == 'Date'
      return time.to_time.to_i
    else
      return time.to_i
    end
  end
end