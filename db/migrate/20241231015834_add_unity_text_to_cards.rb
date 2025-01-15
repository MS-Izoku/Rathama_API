# frozen_string_literal: true

class AddUnityTextToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :unity_text, :text
  end
end
