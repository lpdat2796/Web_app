class Book < ApplicationRecord
    mount_uploader :file, BookUploader
end
