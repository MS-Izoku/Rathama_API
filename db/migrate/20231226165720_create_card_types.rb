# frozen_string_literal: true

class CreateCardTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :card_types do |t|
      t.integer :card_type_attribute_id
      t.integer :card_id

      t.timestamps
    end
  end
end
