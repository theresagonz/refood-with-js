class Comment < ApplicationRecord
  belongs_to :giver
  belongs_to :requestor
  belongs_to :offer
end
