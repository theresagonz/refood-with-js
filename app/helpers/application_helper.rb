module ApplicationHelper
  def format_phone(string)
    phone = string.insert 3, "-"
    phone.insert 7, "-"
  end
 
  def time_string(unit_count)
    unit_count.floor.to_s
  end

  def time_ago(resource)
    seconds_ago = Time.now - resource.created_at
    minutes_ago = seconds_ago/60
    hours_ago = minutes_ago/60
    days_ago = hours_ago/24

    if days_ago.floor > 0
      time_string(days_ago) + " days"
    elsif hours_ago.floor > 0
      time_string(hours_ago) + " hours"
    elsif minutes_ago.floor > 0
      time_string(minutes_ago) + " minutes"
    else
      seconds_ago.floor + " seconds"
    end
  end

  def time_left(offer)
    expiration = Time.strptime(offer.expiration, '%m/%d/%Y %H:%M %p')
    
    seconds_left = expiration - Time.now
    minutes_left = (seconds_left / 60) % 60
    hours_left = (seconds_left / 60 / 60) % 24
    days_left = (seconds_left / 60 / 60 / 24)
    countdown = ''

    if days_left > 0
      countdown << time_string(days_left.floor) + " days "
    end
    if hours_left > 0
      countdown << time_string(hours_left.floor) + " hours "
    end
    if minutes_left > 0
      countdown << time_string(minutes_left.floor) + " minutes "
    end
  countdown
  end
end
