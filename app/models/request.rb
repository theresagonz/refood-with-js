class Request < ApplicationRecord
  belongs_to :offer
  has_many :receivers
  has_one :giver, through: :offer

  validates :message, presence: true
  validate :email_or_phone

  private

    def email_or_phone
      if receiver_phone.blank? && receiver_email.blank?
        errors.add(:base, "Please provide an email address or password")
      end
    end
end
