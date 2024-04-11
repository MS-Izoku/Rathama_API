class ReaddIsPlayableToDecks < ActiveRecord::Migration[7.1]
  def change
    add_column :decks, :is_playable, :boolean, default: false
  end
end
