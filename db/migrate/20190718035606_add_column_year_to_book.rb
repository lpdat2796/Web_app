class AddColumnYearToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :year, :string
  end
end
