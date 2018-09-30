class AddCompletedGiverToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :completed_giver, :boolean, :default => false
  end
end
