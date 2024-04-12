class CreateCardOwnerships < ActiveRecord::Migration[7.1]
  def change
    create_table :card_ownerships do |t|
      t.integer :user_id
      t.integer :card_id

      t.timestamps
    end
  end
end
