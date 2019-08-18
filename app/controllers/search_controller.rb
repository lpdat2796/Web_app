# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    # Condition for if search input not have characters or less than 2
    if params[:search_form].present?
      if params[:search_form][:search].length > 1
        crawl_data
        render :result
      else
        flash[:warning] = 'The search query length should be not less than 2 characters'
        render :index
      end
    else
      render :index
    end
  end

  # Crawl data
  def crawl_data
    @arr  = []
    agent = Mechanize.new
    text  = params[:search_form][:search]
    link  = "https://libgen.is/search.php?req=#{text}&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def"
    page  = agent.get(link)
    data  = page.search 'table.c'
    data  = data.search 'tr'
    data[0..4].each do |dt|
      dt   = dt.search 'td'
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
      link2             = agent.get(dt[9].children.attribute('href').value)
      data2             = link2.search 'td h2 a'
      link2             = "http://93.174.95.29#{data2.attribute('href').value}"
      book.link = link2
      @arr << book
    end
  end
end
