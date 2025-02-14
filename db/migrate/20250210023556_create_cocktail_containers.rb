class CreateCocktailContainers < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktail_containers do |t|
      t.integer :container_id
      t.integer :cocktail_id

      t.timestamps
    end
  end
end
