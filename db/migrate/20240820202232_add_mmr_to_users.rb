class AddMmrToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :mmr, :decimal, precision: 15, scale: 2
  end
end
