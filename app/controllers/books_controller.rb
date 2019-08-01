# frozen_string_literal: true

class BooksController < ApplicationController
  # Show book
  def index
    if current_user.is_admin?
      @book = Book.all
    else
      @book = Book.where(user_id: current_user.id)
    end
  end

  # Save book
  def create
    # Select books that checked
    book_params = params['books'].select { |p| p['choose'] == '1' }
    book_params.each do |book|
      # Check if there has book in DB, not save if there has
      downloaded_book = Book.find_by(book_id: book[:book_id])
      if downloaded_book.present?
        # Check if user has downloaded this book before
        current_user.books.exists?(book_id: downloaded_book.book_id)
          # Save id of user and book in mediate table
          downloaded_book.users << current_user
        end
      else
        # download(book) has id, book_id, title,... in book_new in method download
        downloaded_book   = download(book)
        downloaded_book.users << current_user
      end
    end
    flash[:success] = 'Book was successfully downloaded.'
    redirect_to books_path
  end

  def destroy
    Book.find_by(id: params[:id]).destroy
    flash[:success] = 'Book was successfully deleted.'
    redirect_to books_path
  end

  private

  # Download book and push it to server
  def download(book_params)
    agent     = Mechanize.new
    # Download to disk without loading to memory
    agent.pluggable_parser.default = Mechanize::Download
    title     = book_params[:title].parameterize.underscore
    extension = book_params[:extension]
    agent.get(book_params[:link]).save(Rails.root.join('public', 'download', "#{title}.#{extension}"))
    book      = Book.new(book_params)
    # Upload file to server by using carrierwave
    File.open("public/download/#{title}.#{extension}") do |f|
      book.file = f
    end
    book.save
    return book
  end
end
