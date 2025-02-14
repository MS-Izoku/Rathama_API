class AddCategoryToContainers < ActiveRecord::Migration[7.1]
  def change
    add_column :containers, :category, :string
  end
end
