class CreateQuestRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :quest_rewards do |t|
      t.integer :quest_id

      t.timestamps
    end
  end
end
