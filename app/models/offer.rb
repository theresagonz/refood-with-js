class Offer < ApplicationRecord
  belongs_to :giver
  has_one :user, through: :giver
  has_many :requests
  has_many :requestors, through: :requests

  validates :headline, presence: true

  scope :group_by_location, -> { where(closed: false).order(state: :asc).order(city: :asc) }

  def giver_name
    self.user.name
  end

  def city_state
    "#{city}, #{state}"
  end

  def self.open_offers
    Offer.where(closed: false).where(deleted: false)
  end

  def time_ago_created
    seconds_ago = Time.now - self.created_at.localtime
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
      time_units_string(seconds_ago.floor, "second")
    end
  end

  def time_units_string(time_ago, unit)
    # convert number to string and pluralize unit if multiple
    if time_ago == 1
      time_ago.to_s + " #{unit} "
    else
      time_ago.to_s + " #{unit}s "
    end
  end

  def created_date
    self.created_at.strftime('%A, %B %e, %Y @ %l:%M %P')
  end
end
