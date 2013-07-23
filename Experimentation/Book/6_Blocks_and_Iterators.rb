=begin
Code blocks are just chunks of code between braces or between do and end. This is a code block:
				{ puts "Hello" }	

All you can do with a block is associate it with a call to a method. You do this by putting the
start of the block at the end of the source line containing the method call.Все, что вы можете сделать с блока связать его с вызова метода. Вы делаете это, поместив начало блока в конце строки, содержащей источник вызова метода
For example, in the following code, the block containing puts "Hi" is associated with the call to
the method greet (which we don’t show):
				greet	{ puts "Hi" }


If the method has parameters, they appear before the block:

			verbose_greet("Dave", "loyal customer") { puts "Hi" }
=end

# A method can then invoke an associated block one or more times using the Ruby yield statement.

	def call_block
		puts "Start of method"
		yield
		yield
		puts "End of method"
	end
		call_block { puts "In the block" }
=begin
You can provide arguments to the call to yield, and they will be passed to the block. Within the
block, you list the names of the parameters to receive these arguments between vertical bars
(|params...|).
=end
puts "________________________________________"
		def who_says_what
			yield("Dave", "hello")
			yield("Andy", "goodbye")
		end

		who_says_what {|person, phrase| puts "#{person} says #{phrase}"}
=begin
Code blocks are used throughout the Ruby library to implement iterators, which are methods
that return successive elements from some kind of collection, such as an array:
=end

				animals = %w( ant bee cat dog elk )
				animals.each {|animal| puts animal }
# Many of the looping constructs that are built into languages such as C and Java are simply
# method calls in Ruby, with the methods invoking the associated block zero or more times:
puts "________________________________________"


[ 'cat', 'dog', 'horse' ].each {|name| print name, " " }
5.times { print "*" }
3.upto(6) {|i| print i }
('a'..'e').each {|char| print char }
puts

=begin
Here we ask an array to call the block once for each of its elements. Then, object 5 calls a block
five times. Rather than use for loops, in Ruby we can ask the number 3 to call a block, passing in
successive values until it reaches 6. Finally, the range of characters from a to e invokes a block
using the method each.
=end

