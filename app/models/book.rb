class Book < ApplicationRecord
    mount_uploader :file, BookUploader

    has_many :books_users
end
