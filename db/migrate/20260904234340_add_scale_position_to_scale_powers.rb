class AddScalePositionToScalePowers < ActiveRecord::Migration[7.1]
  def change
    add_column :scale_powers, :scale_position, :string
    add_column :scale_powers, :string, :string
  end
end
