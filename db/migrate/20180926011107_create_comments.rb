class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :giver_id
      t.integer :requestor_id
      t.text :comment_for_giver
      t.text :comment_for_requestor
    end
  end
end
