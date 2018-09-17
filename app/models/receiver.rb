class Receiver < ApplicationRecord
  belongs_to :user
  has_many :requests
  has_many :offers, through: :requests
end
