class Comment < ApplicationRecord
  belongs_to :request
  has_one :requestor, through: :request
  has_one :offer, through: :request
  has_one :giver, through: :offer
end
