# frozen_string_literal: true

class CreateCardTypeAttributes < ActiveRecord::Migration[7.1]
  def change
    create_table :card_type_attributes do |t|
      t.string :name
      t.text :description
      t.string :type, null: false

      t.timestamps
    end
  end
end
