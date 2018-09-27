class AddOfferIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :offer_id, :integer
  end
end
