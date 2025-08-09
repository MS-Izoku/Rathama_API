class AddReleaseDateToExpansions < ActiveRecord::Migration[7.1]
  def change
    add_column :expansions, :release_date, :date
    add_column :expansions, :on_time, :boolean, default: false
    add_column :expansions, :expected_release_date, :date
  end
end
