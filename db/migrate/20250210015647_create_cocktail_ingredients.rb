class CreateCocktailIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktail_ingredients do |t|
      t.integer :cocktail_id
      t.integer :ingredient_id
      t.float :quantity
      t.string :unit

      t.timestamps
    end
  end
end
