class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.integer :giver_id
      t.string :headline
      t.string :city
      t.string :state
      t.text :description
      t.string :availability
      t.boolean :closed, :default => false
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
