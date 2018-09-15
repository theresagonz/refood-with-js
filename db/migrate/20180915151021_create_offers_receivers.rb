class CreateOffersReceivers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers_receivers do |t|
      t.integer :offer_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
