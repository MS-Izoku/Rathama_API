# frozen_string_literal: true

class CreateExpansions < ActiveRecord::Migration[7.1]
  def change
    create_table :expansions do |t|
      t.string :name
      t.text :description
      t.string :tagline

      t.integer :expansion_group_id, default: 0

      t.timestamps
    end
  end
end
