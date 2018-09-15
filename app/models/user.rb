class User < ApplicationRecord
  has_one :giver
  has_one :receiver
  has_many :offers, through: :giver
  has_many :offers, through: :receiver
end
