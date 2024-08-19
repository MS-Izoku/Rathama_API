class CreateQuestRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :quest_rewards do |t|
      t.integer :quest_id
      t.integer :rewardable_id
      t.string :rewardable_type
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
