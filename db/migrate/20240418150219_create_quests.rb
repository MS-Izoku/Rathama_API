# frozen_string_literal: true

class CreateQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :quests do |t|
      t.string :name
      t.string :description
      t.integer :target_completion_value
      t.string :quest_type, default: 'Daily'
      t.datetime :expiration
      t.boolean :can_expire, default: false

      t.timestamps
    end
  end
end
