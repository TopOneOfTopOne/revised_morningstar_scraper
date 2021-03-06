# Stock Info
# Scrapes mourning star website

require_relative 'dividends_scraper'
require_relative 'stock_info_scraper'
require_relative 'calc_profit' # for stock class
@EX_DIV_DATE = Time.parse('13/04/2016')
@MONEY       = 4000

outputFile = File.open(File.expand_path('info.txt',File.dirname(__FILE__)), 'w')

def get_upcoming_dividends
	DivScraper.get_stocks.map do |dividend|
		ex_div_date = Time.parse(dividend[:ex_div_date])
		dividend if (ex_div_date.strftime('%x') ==  @EX_DIV_DATE.strftime('%x'))
	end.compact
end

get_upcoming_dividends.each do |dividend|
  info = StockInfo.get_info(dividend[:code])
  div_yield = dividend[:amount].to_f/info[:last_price].to_f
  info = info.merge({div_yield: div_yield}).merge(dividend)
  info.each {|k,v| outputFile.puts "#{k}: #{v}"}
  outputFile.puts Stock.new(info[:last_price].to_f, info[:amount].to_f, @MONEY.to_f, info[:franking].to_f).details
  outputFile.puts '=============='
end


