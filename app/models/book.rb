# frozen_string_literal: true

class Book < ApplicationRecord
  # create virtual column for table book
  attr_accessor :choose

  mount_uploader :file, BookUploader

  has_many :users, through: :books_users
end
