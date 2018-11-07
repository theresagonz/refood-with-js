class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :offer_id
      t.integer :requestor_id
      t.text :message
      t.string :requestor_email
      t.string :requestor_phone
      t.boolean :completed_giver, :default => false
      t.boolean :completed_requestor, :default => false

      t.timestamps
    end
  end
end
