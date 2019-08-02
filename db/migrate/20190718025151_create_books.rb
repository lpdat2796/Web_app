# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer   :book_id
      t.string    :author
      t.string    :title
      t.string    :publisher
      t.datetime  :year
      t.integer   :page
      t.date      :year
      t.string    :language
      t.string    :size
      t.string    :extension
      t.string    :link

      t.timestamps
    end
  end
end
