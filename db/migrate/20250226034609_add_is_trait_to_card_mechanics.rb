class AddIsTraitToCardMechanics < ActiveRecord::Migration[7.1]
  def change
    add_column :card_mechanics, :is_trait, :boolean, default: false
  end
end
