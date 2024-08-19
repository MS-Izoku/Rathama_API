class CreateUserCurrencies < ActiveRecord::Migration[7.1]
  def change
    create_table :user_currencies do |t|
      t.integer :user_id
      t.integer :currency_id
      t.integer :quantity

      t.timestamps
    end
  end
end
