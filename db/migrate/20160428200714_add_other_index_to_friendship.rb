class AddOtherIndexToFriendship < ActiveRecord::Migration
  def change
    add_index :friendships, [:friended_id, :friender_id], unique: true
  end
end
