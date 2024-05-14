class CreateReleaseNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :release_notes do |t|
      t.text :text
      t.integer :version_id

      t.timestamps
    end
  end
end
