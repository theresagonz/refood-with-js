class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone

      t.timestamps
    end
  end
end
