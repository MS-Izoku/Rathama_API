# frozen_string_literal: true

class CreateScalePowers < ActiveRecord::Migration[7.1]
  def change
    create_table :scale_powers do |t|
      t.string :name
      t.text :description
      t.string :art_url
      t.integer :player_class_id
      t.integer :cost

      t.timestamps
    end
  end
end
