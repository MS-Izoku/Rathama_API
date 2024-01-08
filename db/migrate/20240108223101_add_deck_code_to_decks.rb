class AddDeckCodeToDecks < ActiveRecord::Migration[7.1]
  def change
    add_column :decks, :deck_code, :string
  end
end
