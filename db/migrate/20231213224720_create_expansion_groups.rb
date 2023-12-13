class CreateExpansionGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :expansion_groups do |t|
      t.string :name
      t.integer :year
      t.string :icon_url


      t.timestamps
    end
  end
end
