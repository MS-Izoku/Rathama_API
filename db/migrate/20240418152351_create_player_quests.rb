class CreatePlayerQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :player_quests do |t|
      t.integer :user_id
      t.integer :quest_id
      t.integer :current_completion_value
      t.integer :target_completion_value

      t.timestamps
    end
  end
end
