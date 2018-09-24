module ApplicationHelper
  def format_phone(string)
    phone = string.insert 3, "-"
    phone.insert 7, "-"
  end
  
  def time_units_string(time_ago, unit)
    # convert number to string and pluralize unit if multiple
    if time_ago == 1
      time_ago.to_s + " #{unit} "
    else
      time_ago.to_s + " #{unit}s "
    end
  end

  def expired(offer)
    # convert expiration string to datetime object
    expiration = Time.strptime(offer.expiration, '%m/%d/%Y %H:%M %p')
    # check if expiration is past
    expiration < Time.now
  end

  def time_ago(resource)
    seconds_ago = Time.now - resource.created_at
    minutes_ago = (seconds_ago/60).floor
    hours_ago = (minutes_ago/60).floor
    days_ago = (hours_ago/24).floor

    # get time estimate in days, hours, or minutes
    if days_ago > 0
      time_units_string(days_ago, "day")
    elsif hours_ago > 0
      time_units_string(hours_ago, "hour")
    elsif minutes_ago > 0
      time_units_string(minutes_ago, "minute")
    else
      time_units_string(seconds_ago, "second")
    end
  end

  def time_from_expiration(offer)
    expiration = Time.strptime(offer.expiration, '%m/%d/%Y %H:%M %p')
    
    seconds_away = expiration - Time.now
    minutes_away = ((seconds_away / 60) % 60).floor
    hours_away = ((seconds_away / 60 / 60) % 24).floor
    days_away = ((seconds_away / 60 / 60 / 24)).floor

    if days_away > 0
      time_units_string(days_away, 'day') + time_units_string(hours_away, 'hour') + time_units_string(minutes_away, 'minutes')
    elsif hours_away > 0
      time_units_string(hours_away, 'hour') + time_units_string(minutes_away, 'minute')
    elsif minutes_away > 0
      time_units_string(minutes_away, 'minute')
    else      
      time_units_string(seconds_away, 'second')
    end
  end
end
