class AddDeletedToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :deleted, :boolean, :default => false
  end
end
