class CreateCocktails < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.text :description
      t.text :richtext
      t.integer :card_id

      t.timestamps
    end
  end
end
