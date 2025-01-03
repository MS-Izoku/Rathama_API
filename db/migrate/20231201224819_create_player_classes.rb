# frozen_string_literal: true

class CreatePlayerClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :player_classes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
