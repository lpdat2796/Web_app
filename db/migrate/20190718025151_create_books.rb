class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer   :book_id          
      t.string    :author
      t.string    :title
      t.string    :publisher
      t.date      :year
      t.integer   :page             
      t.string    :language
      t.string    :size
      t.string    :extension
      t.string    :action_link
      

      t.timestamps
    end
  end
end
