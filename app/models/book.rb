# frozen_string_literal: true

class Book < ApplicationRecord
  # create virtual column for table book
  attr_accessor :choose

  mount_uploader :file, BookUploader

  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users
  # ddd
end
