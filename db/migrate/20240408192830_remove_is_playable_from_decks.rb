# frozen_string_literal: true

class RemoveIsPlayableFromDecks < ActiveRecord::Migration[7.1]
  def change
    remove_column :decks, :is_playable, :boolean
  end
end
