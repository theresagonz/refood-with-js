class RenameRequestorIdToRequestIdComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :requestor_id, :request_id
  end
end
