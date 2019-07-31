class Book < ApplicationRecord
    # biet cai nay ko, hk, ma khoan, de t note lai
    # attr_accessor làm 3 thứ
    # 1. tao biến @choose cho m
    # 2. tạo 1 method set: def set_choose @chose = ...
    # 3. tạo 1 method get: def get_choose
    # giống trong oop đó, mà này nó 1 dòng thôi
    attr_accessor :choose

    mount_uploader :file, BookUploader

    has_many :books_users
end
