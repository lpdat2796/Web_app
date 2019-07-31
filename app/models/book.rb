class Book < ApplicationRecord
    # create virtual column for table book
    attr_accessor :choose

    mount_uploader :file, BookUploader

    has_many :books_users
end
