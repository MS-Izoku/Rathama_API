class CreateCardMechanicAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :card_mechanic_assignments do |t|
      t.integer :card_id
      t.string :as_string
      t.string :lifecycle_stage
      t.string :mechanic_string

      t.timestamps
    end
  end
end
