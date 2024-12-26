# frozen_string_literal: true

class CreatePlayerCardPacks < ActiveRecord::Migration[7.1]
  def change
    create_table :player_card_packs, id: :uuid do |t|
      t.integer :user_id
      t.integer :card_pack_id
      t.datetime :date_opened
      t.boolean :opened

      t.timestamps
    end
  end
end
