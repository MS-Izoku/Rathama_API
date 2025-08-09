class AddIsReleasedToExpansions < ActiveRecord::Migration[7.1]
  def change
    add_column :expansions, :released, :boolean
  end
end
