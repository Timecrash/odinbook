class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friender_id
      t.integer :friended_id
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
