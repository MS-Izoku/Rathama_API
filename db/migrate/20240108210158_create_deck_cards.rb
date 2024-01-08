class CreateDeckCards < ActiveRecord::Migration[7.1]
  def change
    create_table :deck_cards do |t|
      t.integer :deck_id
      t.string :card_id_integer

      t.timestamps
    end
  end
end
