class AddUploadTokenToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :upload_token, :string
  end
end
