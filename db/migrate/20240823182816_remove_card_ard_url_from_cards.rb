# frozen_string_literal: true

class RemoveCardArdUrlFromCards < ActiveRecord::Migration[7.1]
  def change
    remove_column :cards, :card_art_url, :string
  end
end
