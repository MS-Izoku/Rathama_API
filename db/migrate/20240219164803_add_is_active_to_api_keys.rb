class AddIsActiveToApiKeys < ActiveRecord::Migration[7.1]
  def change
    add_column :api_keys, :is_active, :boolean
  end
end
