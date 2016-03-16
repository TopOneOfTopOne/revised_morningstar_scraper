# scrapes upcoming stock dividends
require 'nokogiri'
require 'open-uri'
require 'yaml'

module DivScraper
  @URL = 'http://www.morningstar.com.au/Stocks/UpcomingDividends'
  @page = Nokogiri::HTML(open(@URL))
  @rows = @page.css('div#wrapper div#maincontent div.LayerFatter5 table#OverviewTable.table2.tablesorter.dividendhisttable tr')

  def get_stocks
    sanitise_stocks.map do |stock|
    	code, name, ex_div_date, div_pay_date, amount, franking = stock
      {code: code, name: name, ex_div_date: ex_div_date, div_pay_date: div_pay_date, amount: amount, franking: franking}
    end
  end

  def sanitise_stocks
   @rows.map do |row|
     stock = row.css('td').map {|el| el.text.gsub(/\s+/,'')}
     next if (stock[0].nil? || stock[0].length > 3)
     stock
   end.compact
  end

  module_function :get_stocks, :sanitise_stocks
end

# p DivScraper.sanitise_stocks
 # p DivScraper.get_stocks