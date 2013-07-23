class BookInStock
	def initialize(isbn, price)
	  @isbn = isbn
	  @price = Float(price)
	end

	
	def to_s
	  "ISBN:#{@isbn}, PRICE: #{@price}"
	end
end

a_book = BookInStock.new("isbn1", "3.654")
p a_book
puts a_book #default formatting leaves something to be desired

=begin
Ruby has a standard message, to_s, that it sends to any object it wants to render as a string. So,
when we pass one of our BookInStock objects to puts, the puts method calls to_s in that object
to get its string representation. 
=end


