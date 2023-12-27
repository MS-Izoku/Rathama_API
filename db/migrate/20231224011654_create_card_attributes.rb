class CreateCardAttributes < ActiveRecord::Migration[7.1]
  def change
    create_table :card_attributes do |t|
      t.integer :card_id
      t.integer :card_type_attribute_id
      t.string :type, null: false

      t.timestamps
    end
  end
end
