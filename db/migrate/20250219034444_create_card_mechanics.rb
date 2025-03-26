class CreateCardMechanics < ActiveRecord::Migration[7.1]
  def change
    create_table :card_mechanics do |t|
      t.string :name
      t.text :description
      t.string :args
      t.string :as_string

      t.timestamps
    end
  end
end
