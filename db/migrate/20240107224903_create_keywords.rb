# frozen_string_literal: true

class CreateKeywords < ActiveRecord::Migration[7.1]
  def change
    create_table :keywords do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
