class AddPlayabilityStatusToDecks < ActiveRecord::Migration[7.1]
  def change
    add_column :decks, :playability_status, :string
  end
end
