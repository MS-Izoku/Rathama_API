# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      # Display Information
      t.string :name
      t.string :card_text
      t.integer :cost

      # Cosmetic information
      t.text :flavor_text
      t.string :rarity
      t.string :card_art_url

      t.string :type

      # Card Data for Card Types (Fiend/Spell/Trap/Monument/Weapon/Hero)
      t.integer :attack
      t.integer :health
      t.integer :armor
      t.integer :durability


      # Foreign Key Ids
      t.integer :expansion_id, default: 1

      t.timestamps
    end
  end
end
