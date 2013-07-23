# A Ruby iterator is simply a method that can invoke a block of code.

def three_times
  yield
  yield
  yield
end
three_times { puts "Hello" }

#  Fibonacci series up to a certain value:

def fib_up_to(max)
  i1, i2 = 1,1	# parallel assignment (i1 = 1 and i2 = 1)
  while i1 <= max
    yield i1
    i1, i2 = i2, i1+i2
  end
end


fib_up_to (10000) {|f| print f ," "}

# __________________________________________________________
# This is how the find method used by class Array works
class Array
  def find
    for i in 0...size
      value = self[i]
      return value if yield(value)
    end
    return nil
  end
end

p [1, 2, 3, 4, 5, 6, 7].find {|v| v > 6}

# Some iterators are common to many types of Ruby collections. We’ve looked at find already.
# Two others are each and collect. each is probably the simplest iterator—all it does is yield
# successive elements of its collection:

# Another common iterator is collect (also known as map), which takes each element from the
# collection and passes it to the block. The results returned by the block are used to construct a
# new array. The following example uses the succ method, which increments a string value:

["H", "A", "L"].collect {|x| x.succ } # => ["I", "B", "M"]

#__________________________

f = File.open("StockOfBook/data.csv")
f.each do |line|
puts "The line is: #{line}"
end
f.close

# Sometimes you want to keep track of how many times you’ve been through the block. The
# each_with_index method is your friend. It calls its block with two parameters: the current ele-
# ment of the iteration and the count (which starts at zero, just like array indices):

f = File.open("StockOfBook/data.csv")
f.each_with_index do |line, index|
puts "Line #{index} is: #{line}"
end
f.close

puts "________________________________________________INJECT"

=begin
The (somewhat obscurely named) inject method (defined
in the module Enumerable) lets you accumulate a value across the members of a collection. For
example, you can sum all the elements in an array and find their product using code such as this:
=end

p [1,3,5,7].inject(10) {|sum, element| sum+element}
# => 26
p [1,3,5,7].inject(1) {|product, element| product*element} # => 105

=begin
inject works like this: the first time the associated block is called, sum is set to inject’s parameter,
and element is set to the first element in the collection. The second and subsequent times the
block is called, sum is set to the value returned by the block on the previous call. The final value
of inject is the value returned by the block the last time it was called. One more thing: if inject
is called with no parameter, it uses the first element of the collection as the initial value and
starts the iteration with the second value. This means that we could have written the previous
examples like this:
=end
[1,3,5,7].inject {|sum, element| sum+element}
# => 16
[1,3,5,7].inject {|product, element| product*element} # => 105


=begin And, just to add to the mystique of inject, you can also give it the name of the method you
want to apply to successive elements of the collection. These examples work because, in Ruby,
addition and multiplication are simply methods on numbers, and :+ is the symbol corresponding
to the method +:
=end
[1,3,5,7].inject(:+) # => 16
[1,3,5,7].inject(:*) # => 105
