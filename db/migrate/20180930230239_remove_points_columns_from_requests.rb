class RemovePointsColumnsFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :giver_point
    remove_column :requests, :requestor_point
  end
end
