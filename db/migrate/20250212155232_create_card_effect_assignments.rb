class CreateCardEffectAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :card_effect_assignments do |t|
      t.integer :card_effect_id
      t.integer :card_id

      t.timestamps
    end
  end
end
