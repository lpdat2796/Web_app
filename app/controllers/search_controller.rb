class SearchController < ApplicationController


  def index
    # Condition for if search input not have letter or less than 2
    if params[:search_form].present? 
      if params[:search_form][:search].length > 1
        # code crawl
        crawl_data
        render :result
        else
          flash[:warning] = "The search query length should be not less than 2 characters"
          render :index
        end
    else
      render :index
    end

  end

  # Crawl data
  def crawl_data
    @arr  = Array.new
    agent = Mechanize.new
    text  = params[:search_form][:search]
    link  = "https://libgen.is/search.php?req=" << text << "&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def"
    page  = agent.get(link)
    data  = page.search "table.c"
    data  = data.search "tr"
    data[0..3].each do |dt|
      dt   = dt.search "td"
      book = Book.new
      next if dt[0].text == 'ID'
      book.book_id      = dt[0].text
      book.author       = dt[1].text
      book.title        = dt[2].text
      dt[2].search('font').each do |str|
        book.title.gsub!(str.text, '')
        # If not have ! sympol, must assign book.title = ...
      end
      book.publisher    = dt[3].text
      book.year         = dt[4].text
      book.page         = dt[5].text
      book.language     = dt[6].text
      book.size         = dt[7].text
      book.extension    = dt[8].text

      # Get link download from page 93.174.95.29
      link2             = agent.get(dt[9].children.attribute("href").value )
      data2             = link2.search "td h2 a"
      link2             = "http://93.174.95.29#{data2.attribute("href").value}"
      book.link  = link2
      @arr << book
    end
  end
  # Save book
  def get_book 
    # Check book if there has in DB, not save if there has
    find_book= Book.find_by_book_id(params[:book][:book_id])
    if find_book.present?
      # byebug
      # Save id of user and book in mediate table
      book_user = BooksUser.new
      book_user.book_id = find_book.id
      book_user.user_id = current_user.id
      book_user.save
      redirect_to show_path
    else
      create
      book_user = BooksUser.new
      book_user.book_id = Book.find_by_book_id(params[:book][:book_id]).id
      book_user.user_id = current_user.id
      book_user.save
      redirect_to show_path
    end
  end 

  def show_book
    if current_user.is_admin?
      @book_user = BooksUser.all
    else
      @books = Book.joins("INNER JOIN books_users ON books_users.book_id = books.id AND books_users.user_id = #{current_user.id}")
    end
  end

  def delete_book
    book = BooksUser.find_by(id: params[:id])
    book.destroy
    flash[:success] = "Delete successfully."
    byebug
    redirect_back fallback_location: show_url
  end

  private
  # Download book and push it to server
  def create
    agent = Mechanize.new    
    #Download to disk without loading to memory
    agent.pluggable_parser.default = Mechanize::Download
    title = params[:book][:title].parameterize.underscore
    extension = params[:book][:extension]
    agent.get(params[:book][:link]).save(Rails.root.join('public', 'download', "#{title}.#{extension}"))
    book = Book.new
    book.book_id      = params[:book][:book_id]
    book.author       = params[:book][:author]
    book.title        = params[:book][:title]
    book.publisher    = params[:book][:publisher]
    book.year         = params[:book][:year]
    book.page         = params[:book][:page]
    book.language     = params[:book][:language]
    book.size         = params[:book][:size]
    book.extension    = params[:book][:extension]
    book.link  = params[:book][:link]
    #Upload file to server by using carrierwave
    File.open("public/download/#{title}.#{extension}") do |f|
      book.file = f
    end
    book.save!
  end
  
end

