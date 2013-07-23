a = [3.14, "pie", 99]
a.class		#=> Array
a.length	#=> 3
a[0]		#=> 3.14
a[2]		#=> 99
a[4]		#=> nil


b = Array.new
b.class		#=> Array
b.length	#=> 0
b[0] = "asd"	
b[1] = "array"	
b		#=> ["asd","array"]
#--------------------------------------------------------------------
a = ["ant","bat","cat","dog","elk","fly","gnu"]

a[2]			#=> "cat"
a[-3]			#=> "elk"
a[1..3]			#=> "bat","cat","dog"
a[1...3]		#=> "bat","cat"
a[-3..-1]		#=> "elk","fly","gnu"
a[4..-2]		#=> "elk","fly"

#--------------------------------------------------------------------

# You can also index arrays with a pair of numbers, [start,count ]. This returns a new array con-
# sisting of references to count objects starting at position start:

a = [ 1, 3, 5, 7, 9 ]
a[1, 3] # => [3, 5, 7]
a[3, 1] # => [7]
a[-3, 2] # => [5, 7]

# =====================================================================
# The [ ] operator has a corresponding [ ]= operator, which lets you set elements in the array.


a = [ 1, 3, 5, 7, 9 ]	#=> [1, 3, 5, 7, 9]
a[2, 2] = "cat"		#=> [1, 3, "cat", 9]
a[2, 0] = "dog"		#=> [1, 3,"dog","cat", 9]
a[1, 1] = [ 9, 8, 7 ]	#=> [1, 9, 8, 7,"dog","cat", 9]
a[0..3] = []		#=> ["dog","cat", 9]
a[5..6] = 99, 98	#=> ["dog","cat", 9, nil, nil, 99, 98]

# ======================================================================

# Arrays have a large number of other useful methods. Using them, you can treat arrays as stacks,
#sets, queues, dequeues, and FIFO queues.
# For example, push and pop add and remove elements from the end of an array, so you can use
#the array as a stack:
puts "________________________________________________PUSH_POP"
stack = []
stack.push "red"
stack.push "green"
stack.push "blue"
stack.push 1234567
p stack
puts stack.pop
puts stack.pop
puts stack.pop
p stack

# Similarly, unshift and shift add and remove elements from the head of an array. Combine shift
# and push, and you have a first-in first-out (FIFO) queue.
puts "________________________________________________PUSH_SHIFT"
queue = []
queue.push "red"
queue.push "green"
p queue
puts queue.shift
puts queue.shift
puts "________________________________________________UNSHIFT_SHIFT"
queue.unshift "what"
queue.unshift "is"
queue.unshift "it?"
p queue
puts queue.shift
puts queue.shift
puts queue.shift
puts "________________________________________________UNSHIFT_POP"
queue.unshift "what"
queue.unshift "is"
queue.unshift "it?"
p queue
puts queue.pop
puts queue.pop
puts queue.pop

puts "________________________________________________FIRST_LAST"
# The first and last methods return the n entries at the head or end of an array without removing
# them:
array = [ 1, 2, 3, 4, 5, 6, 7 ]
p array.first(4)
p array.last(4)
