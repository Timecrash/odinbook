class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :e-mail

      t.timestamps null: false
    end
  end
end
