class OffersReceiver < ApplicationRecord
  belongs_to :offer
  belongs_to :receiver
end
