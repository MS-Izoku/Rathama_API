# frozen_string_literal: true

class CreateConnectedCards < ActiveRecord::Migration[7.1]
  def change
    create_table :connected_cards do |t|
      t.integer :master_card_id
      t.integer :child_card_id

      t.timestamps
    end
  end
end
