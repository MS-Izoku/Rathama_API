class CreateClientVersions < ActiveRecord::Migration[7.1]
  def change
    create_table :client_versions do |t|
      t.string :version_name
      t.string :version_number

      t.timestamps
    end
  end
end
