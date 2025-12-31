class ChangeDeckOwnerIdToInt < ActiveRecord::Migration[7.1]
  def up
    # Drop foreign key constraint if it exists
    remove_foreign_key :decks, :users, column: :owner_id if foreign_key_exists?(:decks, :users, column: :owner_id)

    # Change owner_id column to integer
    change_column :decks, :owner_id, :integer, using: 'owner_id::integer'
  end

  def down
    # Drop foreign key constraint if it exists (for rollback)
    remove_foreign_key :decks, :users, column: :owner_id if foreign_key_exists?(:decks, :users, column: :owner_id)

    # Revert owner_id column to string
    change_column :decks, :owner_id, :string
  end
end
