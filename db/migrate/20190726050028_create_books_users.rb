# frozen_string_literal: true

class CreateBooksUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :books_users do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
