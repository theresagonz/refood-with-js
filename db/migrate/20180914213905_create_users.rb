class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :type
      t.string :name
      t.string :business_name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :phone
      t.boolean :show_address

      t.timestamps
    end
  end
end
