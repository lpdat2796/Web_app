class SearchController < ApplicationController
  def index;end

  def create
    @arr  = Array.new
    agent = Mechanize.new
    text  = params[:search_form][:search]
    link  = "https://libgen.is/search.php?req=" << text << "&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def"
    page  = agent.get(link)
    data  = page.search "table.c"
    data  = data.search "tr"
    data.each do |dt|
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
      @arr << book
    end
  end
  def get 
    agent = Mechanize.new    
    #Download to disk without loading to memory
    agent.pluggable_parser.default = Mechanize::Download
    title = params[:title].parameterize.underscore
    binding.pry
    agent.get(params[:url]).save("download",title) 
    redirect_to search_index_path	
  end 
end

