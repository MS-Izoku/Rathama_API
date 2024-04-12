class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :api_key_digest

      t.timestamps
    end

    add_index :api_keys, [:owner_id, :owner_type]
    add_index :api_keys, :api_key_digest, unique: true
  end
end
