class AddIndexToFriendship < ActiveRecord::Migration
  def change
    add_index :friendships, :friender_id
    add_index :friendships, :friended_id
    add_index :friendships, [:friender_id, :friended_id], unique: true
  end
end
