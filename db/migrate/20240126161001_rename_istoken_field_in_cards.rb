# frozen_string_literal: true

class RenameIstokenFieldInCards < ActiveRecord::Migration[7.1]
  def change
    rename_column :cards, :is_token, :is_generated_card
  end
end
