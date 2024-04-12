class CreateCardPacks < ActiveRecord::Migration[7.1]
  def change
    create_table :card_packs do |t|
      t.integer :expansion_id
      t.integer :cards_per_pack

      t.timestamps
    end
  end
end
