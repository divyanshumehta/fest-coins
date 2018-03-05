class RemoveUniqureUserId < ActiveRecord::Migration[5.0]
  def change
  end
  remove_index :transcations, :user_id
  add_index :transcations, :user_id
end
