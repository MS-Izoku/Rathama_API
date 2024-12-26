# frozen_string_literal: true

class AddGenerationStatusToDecks < ActiveRecord::Migration[7.1]
  def change
    add_column :decks, :generation_status, :string
  end
end
