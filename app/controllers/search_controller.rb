class SearchController < ApplicationController
    def index

    end

    def create
        @arr = Array.new
        text = params[:search_form][:search]
        # byebug
        link = "https://libgen.is/search.php?req=" << text << "&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def"
        agent = Mechanize.new
        page = agent.get(link)
        data = page.search "table.c"
        data = data.search "tr"
        data.each do |dt|
            dt = dt.search "td"
            book = Book.new
            next if dt[0].text == 'ID'
            book.book_id      = dt[0].text
            book.author       = dt[1].text
            book.title        = dt[2].text
            book.publisher    = dt[3].text
            book.year         = dt[4].text
            book.page         = dt[5].text
            book.language     = dt[6].text
            book.size         = dt[7].text
            book.extension    = dt[8].text
            book.action_link  = dt[11].children.attribute("href").value 
            @arr << book

        end
       
    end
    def show
        
    end
    
end

