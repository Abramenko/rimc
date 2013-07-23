#CSV - comma separated values
class BookInStock
	attr_reader :isbn
	attr_accessor :price

	def initialize(isbn, price)
	  @isbnn = isbn
	  @price = price
	end
end

class CsvReader

	def initialize
	  @book_in_stock = []
	end
#-----------------------------------------
	def read_in_csv_data(csv_file_name)
	  CSV.foreach(csv_file_name,headers: true) do |row|
	  @book_in_stock << BookInStock.new(row["ISBN"],row["Amount"])				
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
		#...
	end
#-----------------------------------------
	def number_of_each_stock
		#..
	end
#-----------------------------------------
end

