class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :offer_id
      t.integer :receiver_id
      t.text :message
      t.string :receiver_email
      t.string :receiver_phone

      t.timestamps
    end
  end
end
