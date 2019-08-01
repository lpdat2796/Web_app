# frozen_string_literal: true

class AddUrlToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :file, :string
  end
end
