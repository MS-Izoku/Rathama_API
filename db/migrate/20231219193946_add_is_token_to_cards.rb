# frozen_string_literal: true

class AddIsTokenToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :is_token, :boolean
  end
end
