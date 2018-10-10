module OffersHelper
  def has_request(user, offer)
    # loop through user's requests to see if matches offer
    user.requests.any? do |request|
      offer.requests.include?(request)
    end
  end

  def number_of_items(collection, thing_string)
    if collection.count == 0
      "No #{thing_string}s"
    elsif collection.count == 1
      "1 #{thing_string}"
    else
      "#{collection.count} #{thing_string}s"
    end
  end
end
