class AddHeroCardIdToScalePowers < ActiveRecord::Migration[7.1]
  def change
    add_column :scale_powers, :hero_card_id, :integer
  end
end
