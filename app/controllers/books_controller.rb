# frozen_string_literal: true

class BooksController < ApplicationController
  # Show book
  def index
    if current_user.is_admin?
      @book_user = BooksUser.all
    else
      @book_user = BooksUser.where(user_id: current_user.id)
    end
  end

  # Save book
  def create
    # Select books that checked
    books = params['books'].select { |p| p['choose'] == '1' }
    books.each do |book|
      # Check if there has book in DB, not save if there has
      find_book = Book.find_by_book_id(book[:book_id])
      book_user = BooksUser.new
      if find_book.present?
        # Check if user has downloaded this book before
        unless BooksUser.find_by(book_id: find_book.id)
          # Save id of user and book in mediate table
          book_user.book_id = find_book.id
          book_user.user_id = current_user.id
          book_user.save
        end
      else
        download(book)
        book_user.book_id = Book.find_by(book_id: book[:book_id]).id
        book_user.user_id = current_user.id
        book_user.save
      end
    end
    flash[:success] = 'Book was successfully downloaded.'
    redirect_to books_path
  end

  def destroy
    BooksUser.find_by(id: params[:id]).destroy
    flash[:success] = 'Book was successfully deleted.'
    redirect_to books_path
  end

  private

  # Download book and push it to server
  def download(book)
    agent = Mechanize.new
    # Download to disk without loading to memory
    agent.pluggable_parser.default = Mechanize::Download
    title = book[:title].parameterize.underscore
    extension = book[:extension]
    agent.get(book[:link]).save(Rails.root.join('public', 'download', "#{title}.#{extension}"))
    book_new = Book.new
    book_new.book_id      = book[:book_id]
    book_new.author       = book[:author]
    book_new.title        = book[:title]
    book_new.publisher    = book[:publisher]
    book_new.year         = book[:year]
    book_new.page         = book[:page]
    book_new.language     = book[:language]
    book_new.size         = book[:size]
    book_new.extension    = book[:extension]
    book_new.link         = book[:link]
    # Upload file to server by using carrierwave
    File.open("public/download/#{title}.#{extension}") do |f|
      book_new.file = f
    end
    book_new.save
  end
end
