# frozen_string_literal: true

class CreateDeckClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :deck_classes do |t|
      t.integer :deck_id
      t.integer :player_class_id

      t.timestamps
    end
  end
end
