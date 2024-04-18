class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.quantity :integer
      t.references :rewardable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
