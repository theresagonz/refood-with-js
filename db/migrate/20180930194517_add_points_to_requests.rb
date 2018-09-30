class AddPointsToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :giver_point, :boolean
    add_column :requests, :requestor_point, :boolean
  end
end
