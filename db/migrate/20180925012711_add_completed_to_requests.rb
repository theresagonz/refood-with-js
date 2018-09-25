class AddCompletedToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :completed, :boolean, :default => false
  end
end
