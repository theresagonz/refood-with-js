class Comment < ApplicationRecord
  belongs_to :giver
  belongs_to :requestor
end
