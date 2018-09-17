class ChangeExpirationTypeForOffers < ActiveRecord::Migration[5.2]
  def change
    change_column :offers, :expiration, :string
  end
end
