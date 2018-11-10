class RequestSerializer < ActiveModel::Serializer
  attributes :id, :offer_id, :requestor_id, :requestor_name, :message, :requestor_email, :requestor_phone, :completed_giver, :completed_requestor, :formatted_phone, :created_date
end
