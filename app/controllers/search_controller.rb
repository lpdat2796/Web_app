class SearchController < ApplicationController
  def index
    if params[:search_form].present?
      # code crawl
      search
      render :result
    else
      render :index
    end
  end

  def get 
    find_book= Book.find_by_book_id(params[:book][:book_id])
    if find_book.present?
      redirect_to search_index_path
    else
      save
      download
      redirect_to search_index_path
    end
  end 

  private

  def search
    @arr  = Array.new
    agent = Mechanize.new
    text  = params[:search_form][:search]
    link  = "https://libgen.is/search.php?req=" << text << "&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def"
    page  = agent.get(link)
    data  = page.search "table.c"
    data  = data.search "tr"
    data[0..1].each do |dt|
      dt   = dt.search "td"
      book = Book.new
      next if dt[0].text == 'ID'
      book.book_id      = dt[0].text
      book.author       = dt[1].text
      book.title        = dt[2].text
      # title             = dt[2].search ("a")
      # book.title        = title.text
      book.publisher    = dt[3].text
      book.year         = dt[4].text
      book.page         = dt[5].text
      book.language     = dt[6].text
      book.size         = dt[7].text
      book.extension    = dt[8].text

      # Get link download 93.174.95.29
      link2             = agent.get(dt[9].children.attribute("href").value )
      data2             = link2.search "td h2 a"
      link2             = "http://93.174.95.29#{data2.attribute("href").value}"
      book.action_link  = link2
      # binding.pry
      @arr << book
    end
  end
  
  def save
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
    book.action_link  = params[:book][:action_link]
    book.save
  end

  def download
    agent = Mechanize.new    
    #Download to disk without loading to memory
    agent.pluggable_parser.default = Mechanize::Download
    title = params[:book][:title].parameterize.underscore
    extension = params[:book][:extension]
    agent.get(params[:book][:action_link]).save(Rails.root.join('public', 'download', "#{title}.#{extension}"))
    #Upload file to server by using carrierwave
    File.open('public/download') do |f|
      book.url = f
    end
    book.save!
  end
  
end

