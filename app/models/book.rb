class Book < ApplicationRecord
    mount_uploader :url, BookUploader
end
