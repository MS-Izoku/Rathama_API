class AddExcludedFromDeckbuildingToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :excluded_from_deckbuilding, :boolean, default: false
  end
end
