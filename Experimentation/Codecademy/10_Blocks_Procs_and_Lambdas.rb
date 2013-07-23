# The collect method takes a block and applies the expression in the block to every element in an 
# array. Check it out:

my_nums = [1, 2, 3]
my_nums.collect { |num| num ** 2 }
# ==> [1, 4, 9]
# If we look at the value of my_nums, though, we'll see it hasn't changed:

my_nums
# ==> [1, 2, 3]


# This is because .collect returns a copy of my_nums, but doesn't change (or mutate) the original 
# my_nums array. If we want to do that, we can use .collect! with an exclamation point:

def block_test
  puts "We're in the method!"
  puts "Yielding to the block..."
  yield
  puts "We're back in the method!"
end

block_test { puts ">>> We're in the block!" }


#----------------------------------------------
def double(num)
yield num 
end
double(3) {|n| n*2}


__________________________________________

# keeping your code DRY, which stands for Don't Repeat Yourself.



multiples_of_3 = Proc.new do |n|
  n % 3 == 0
end

(1..100).to_a.select(&multiples_of_3)

# The & is used to convert the cube proc into a block (since .collect! and .map! normally take a 
# block). We'll do this any time we pass a proc to a method that expects a block.

def greeter
yield
end

phrase = Proc.new {puts "Hello there!"}

greeter(&phrase)

# Unlike blocks, we can call procs directly by using Ruby's .call method. Check it out!

test = Proc.new { puts "I" }
test.call
#=> I



# Well, you can also convert symbols to procs using that handy little &.

strings = ["1", "2", "3"]
nums = strings.map(&:to_i)
# ==> [1, 2, 3]
# By mapping &:to_i over every element of strings, we turned each string into an integer!

 # lambdas are objects
 
def lambda_demo(a_lambda)
  puts "I'm the method!"
  a_lambda.call
end

lambda_demo(lambda { puts "I'm the lambda!"})
 
# _____________________________________________________________

strings = ["leonardo", "donatello", "raphael", "michaelangelo"]

symbolize = lambda {|x| x.to_sym}

symbols = strings.collect(&symbolize)

# First, a lambda checks the number of arguments passed to it, while a proc does not. This means 
# that a lambda will throw an error if you pass it the wrong number of arguments, whereas a proc 
# will ignore unexpected arguments and assign nil to any that are missing.

# Second, when a lambda returns, it passes control back to the calling method; when a proc  
# returns, 
# it does so immediately, without going back to the calling method.

def batman_ironman_proc
  victor = Proc.new { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end

puts batman_ironman_proc

def batman_ironman_lambda
  victor = lambda { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end

puts batman_ironman_lambda

# _____________________________________________________________

my_array = ["raindrops", :kettles, "whiskers", :mittens, :packages]

# Add your code below!

symbol_filter = lambda {|x| x.is_a? Symbol}

symbols = my_array.select(&symbol_filter)

#______________________________________________________________

=begin
A block is just a bit of code between do..end or {}. It's not an object on its own, but it can be passed to methods like .each or .select.
A proc is a saved block we can use over and over.
A lambda is just like a proc, only it cares about the number of arguments it gets and it returns to its calling method rather than returning immediately.
=end
 
