module OffersHelper
  def has_request(user, offer)
    # loop through user's requests to see if matches offer
    user.requests.any? do |request|
      offer.requests.include?(request)
    end
  end
end
