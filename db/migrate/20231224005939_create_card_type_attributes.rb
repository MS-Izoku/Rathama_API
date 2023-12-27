class CreateCardTypeAttribute < ActiveRecord::Migration[7.1]
  def change
    create_table :card_type_attributes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
