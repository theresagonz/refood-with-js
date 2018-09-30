class RemoveOfferIdComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :offer_id
  end
end
