class Request < ApplicationRecord
  belongs_to :receiver
  belongs_to :offer
  has_one :giver, through: :offer
end
