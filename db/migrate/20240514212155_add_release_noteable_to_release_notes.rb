class AddReleaseNoteableToReleaseNotes < ActiveRecord::Migration[7.1]
  def change
    add_column :release_notes, :release_notable_type, :string
    add_column :release_notes, :release_notable_id, :integer
  end
end
