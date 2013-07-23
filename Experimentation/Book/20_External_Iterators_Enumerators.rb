=begin
	It’s also worth spending another paragraph looking at why Ruby’s internal iterators aren’t
always the best solution. One area where they fall down badly is where you need to treat an
iterator as an object in its own right (for example, passing the iterator into a method that needs
to access each of the values returned by that iterator). It’s also difficult to iterate over two collections in parallel using Ruby’s internal iterator scheme.

	Fortunately, Ruby 1.9 comes with a built-in Enumerator class, which implements external iterators in Ruby for just such occasions.

You can create an Enumerator object by calling the to_enum method (or its synonym, enum_for)
on a collection such as an array or a hash:
=end

 a = [ 1, 3, "cat" ]
 h = { dog: "canine", fox: "vulpine" }
# Create Enumerators
 enum_a = a.to_enum
 enum_h = h.to_enum

 enum_a.next #=> 1
 enum_h.next #=> [:dog, "canine"]
 enum_a.next #=> 3
 enum_h.next #=> [:fox, "vulpine"]
p enum_a


# Most of the internal iterator methods—the ones that normally yield successive values to a
# block—will also return an Enumerator object if called without a block:
a = [ 1, 3, "cat" ]
enum_a = a.each # create an Enumerator using an internal iterator
enum_a.next # => 1
enum_a.next # => 3

# Ruby has a method called loop that does nothing but repeatedly invoke its block. Typically, your
# code in the block will break out of the loop when some condition occurs. But loop is also smart
# when you use an Enumerator—when an enumerator object runs out of values inside a loop, the
# loop will terminate cleanly. The following example shows this in action—the loop ends when
# the three-element enumerator runs out of values.


short_enum = (1..100).to_enum
long_enum = ('a'..'z').to_enum
loop do
puts "#{short_enum.next} - #{long_enum.next}"
end


# _________________________________________________________________Enumerators Are Objects_____

# For example, the Enumerable module defines each_with_index. This invokes its host class’s
# each Method, returning successive values along with an index:
result = []
[ 'a', 'b', 'c' ].each_with_index {|item, index| result << [item, index] }
p result  # => [["a", 0], ["b", 1], ["c", 2]]

=begin
But what if you wanted to iterate and receive an index but use a different method than each to
control that iteration? For example, you might want to iterate over the characters in a string.
There’s no method called each_char_with_index built into the String class.
Enumerators to the rescue. The each_char method of strings will return an enumerator if you
don’t give it a block, and you can then call each_with_index on that enumerator:
=end

result = []
"cat".each_char.each_with_index {|item, index| result << [item,index] }
result # => [["c", 0], ["a", 1], ["t", 2]]
p "cat".each_char.each_with_index 

# In fact, this is such a common use of enumerators that Matz has given us with_index, which
# makes the code read better:

result = []
"cat".each_char.with_index {|item, index| result << [item,index] }
result # => [["c", 0], ["a", 1], ["t", 2]]
p "cat".each_char.with_index 

# You can also create the Enumerator object explicitly—in this case we’ll create one that calls our
# string’s each_char method. We can call to_a on that enumerator to iterate over it:

enum = "cat".enum_for(:each_char)
p enum.to_a # => ["c", "a", "t"]



# If the method we’re using as the basis of our enumerator takes parameters, we can pass them to
# enum_for:
enum_in_threes = (1..10).enum_for(:each_slice, 3)
p enum_in_threes.to_a # => [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]







puts "______________________________________Enumerators Are Generators and Filters"
=begin
As well as creating
enumerators from existing collections, you can create an explicit enumerator, passing it a block.
The code in the block will be used when the enumerator object needs to supply a fresh value
to your program. However, the block isn’t simply executed from top to bottom. Instead, the
block is executed in parallel with the rest of your program’s code. Execution starts at the top
and pauses when the block yields a value to your code. When the code needs the next value,
execution resumes at the statement following the yield. This lets you write enumerators that
generate infinite sequences (among other things):
=end

triangular_numbers = Enumerator.new do |yielder|
  number = 0
  count = 1
  loop do
    number += count
    count += 1
    yielder.yield (number)
  end
end
# p [1, 2].each.class
# p [1, 2, 3].to_enum.class
# p [1, 2,3].each {|q|}.class
5.times { print triangular_numbers.next," " }
puts "\n"
p triangular_numbers.first(10)


##############SEE BOOK page 78-85 ###############