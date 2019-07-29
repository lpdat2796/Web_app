class AddDocumentToBooks < ActiveRecord::Migration[5.1]
  def up
    add_column :books, :document, :text 
  end

  def down
    drop_column :books, :document
  end
end
