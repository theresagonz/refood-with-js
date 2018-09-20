module ApplicationHelper
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
end
