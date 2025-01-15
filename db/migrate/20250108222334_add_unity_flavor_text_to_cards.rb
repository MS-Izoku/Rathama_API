# frozen_string_literal: true

class AddUnityFlavorTextToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :unity_flavor_text, :text
  end
end
