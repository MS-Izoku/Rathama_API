class CreateCardEffects < ActiveRecord::Migration[7.1]
  def change
    create_table :card_effects do |t|
      t.string :name
      t.string :description
      t.string :format

      t.timestamps
    end
  end
end
