class CreatePlayerClassCards < ActiveRecord::Migration[7.1]
  def change
    create_table :player_class_cards do |t|
      t.integer :player_class_id
      t.integer :card_id

      t.timestamps
    end
  end
end
