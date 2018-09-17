class Giver < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :requests, through: :offers
end
