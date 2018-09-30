class Requestor < ApplicationRecord
  belongs_to :user
  has_many :requests
  has_many :offers, through: :requests
  has_many :comments, through: :requests
end
