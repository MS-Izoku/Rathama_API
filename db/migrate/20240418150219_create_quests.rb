class CreateQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :quests do |t|
      t.string :name
      t.string :description
      t.integer :target_completion_value
      t.string quest_type :string, default: "Daily"

      t.timestamps
    end
  end
end
