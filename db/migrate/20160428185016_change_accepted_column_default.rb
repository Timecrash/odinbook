class ChangeAcceptedColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :friendships, :accepted, false
  end
end
