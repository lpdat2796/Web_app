class AddUrlToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :url, :string
  end
end
