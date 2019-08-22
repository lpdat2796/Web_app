# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in [2..5]
    Book.find_each(start: 23, finish: 26) do |book|
        byebug
        User.find_each(start: 2, finish: 5) do |user|
            book.users << user
        end
    end
end