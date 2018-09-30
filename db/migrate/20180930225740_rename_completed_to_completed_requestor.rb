class RenameCompletedToCompletedRequestor < ActiveRecord::Migration[5.2]
  def change
    rename_column :requests, :completed, :completed_requestor
  end
end
