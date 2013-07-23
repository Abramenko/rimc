#CSV - comma separated values
require 'csv'
require_relative 'book_in_stock'

=begin
In this file, we use require
to load in the Ruby CSV library and require_relative to load in the book_in_stock file we wrote.
(We use require_relative for this because the location of the file we’re loading is relative to the
file we’re loading it from—they’re both in the same directory.)
=end

class CsvReader

	def initialize
	  @books_in_stock = []
	end
#-----------------------------------------
	def read_in_csv_data(csv_file_name)
	  CSV.foreach(csv_file_name,headers: true) do |row|
	  @books_in_stock << BookInStock.new(row["ISBN"], row["Amount"])				
	end
=begin
On the first line, we tell the CSV library to open the file with the given name. The
headers: true option tells the library to parse the first line of the file as the names of the columns.
We then create a new BookInStock object. We then append that object to an instance variable
called @books_in_stock.

=end
	end
#-----------------------------------------
	def total_value_in_stock
	  sum = 0.0
	  @books_in_stock.each {|book| sum += book.price}
	  sum
	end
#-----------------------------------------
	def number_of_each_isbn
		#...
	end
end

