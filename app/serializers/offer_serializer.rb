class OfferSerializer < ActiveModel::Serializer
  attributes :id, :giver_id, :giver_name, :headline, :description, :city, :state, :city_state, :availability, :closed, :deleted, :created_ago, :created_date
  has_many :requests, serializer: RequestSerializer
end
