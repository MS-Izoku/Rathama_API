class AddDeckSizeModifiersToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :deck_size_modifier_type, :string, default: "None"
    add_column :cards, :deck_size_modifier_value, :integer
  end
end
