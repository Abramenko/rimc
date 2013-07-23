# Internal state (the ISBN and price)
# That state is private to those objects—no other object can access an object’s instance 
# variables. In general, this is a Good Thing. 
# Externally visible facets of an object are called its attributes.
# 
# (calling the external state of an object its attributes, you’re helping clue people in to how
# they should view the class you’ve written)

class BookInStock
	def initialize(isbn, price)
	  @isbn = isbn
	  @price = Float(price)
	end
#_________________________________
	def isbn	# Because writing accessor methods is such a common idiom, Ruby provides a 
			# convenient short-cut. attr_reader creates these attribute reader methods 
	  @isbn		# for you:
	end		#
			#
	def price	#		attr_reader :isbn, :price
	  @price	#
			# It creates the accessor methods, but the variables themselves don’t need 
	end		# to be declared—they
#_______________________# just pop into existence when you use them.
	def to_s
	  "Price = #{@price}; ISBN = #{@isbn}"
	end
#__________________________________________
	def price=(new_price)		# we'll can do
	  @price = new_price		# book.price = book.price / 159.55
	end
#__________________________________________
=begin
Again, Ruby provides a shortcut for creating these simple attribute-setting methods. If you want
a write-only accessor, you can use the form 

				attr_writer,

but that’s fairly rare. You’re far more
likely to want both a reader and a writer for a given attribute, so you’ll use the handy-dandy

				attr_accessor 

method
=end
#___________________________________________
	
end

book = BookInStock.new("isbn", 159.55)
puts "Price = #{book.price}\nISBN = #{book.isbn}"

book.price = book.price / 159.55	#
puts book				#




