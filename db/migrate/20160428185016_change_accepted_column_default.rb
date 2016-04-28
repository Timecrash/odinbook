class ChangeAcceptedColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :users, :accepted, false
  end
end
