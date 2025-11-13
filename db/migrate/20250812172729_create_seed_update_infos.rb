class CreateSeedUpdateInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :seed_update_infos do |t|
      t.datetime :card_type_attributes
      t.datetime :basic_cards
      t.string :mechanics_datetime
      t.datetime :decks

      t.timestamps
    end
  end
end
