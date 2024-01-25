class AddApiKeyDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :api_key_digest, :string
  end
end
