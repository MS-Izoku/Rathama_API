# frozen_string_literal: true

class AddIsCompletedToPlayerQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :player_quests, :is_completed, :boolean
  end
end
