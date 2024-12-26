# frozen_string_literal: true

# this migration should only be added in a Postgres setup, SQLite does not support arrays and serialization for arrays is deprecated
class AddPermissionsToApiKey < ActiveRecord::Migration[7.1]
  def change
    # add_column :api_keys, :permissions, :text, array: true, default: [] # postgres implementation
  end
end
