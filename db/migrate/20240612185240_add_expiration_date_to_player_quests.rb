# frozen_string_literal: true

class AddExpirationDateToPlayerQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :player_quests, :expiration_date, :datetime
  end
end
