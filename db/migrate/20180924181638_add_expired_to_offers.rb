class AddExpiredToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :expired, :boolean, :default => false
  end
end
