class AddFileToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :file, :string
  end
end
