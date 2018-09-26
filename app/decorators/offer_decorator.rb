class OfferDecorator < ApplicationDecorator
  delegate_all
  # decorates :offer, :welcome
  
  def expired
    Time.strptime(f.expiration, '%m/%d/%Y %H:%M %p').past?
  end
end
