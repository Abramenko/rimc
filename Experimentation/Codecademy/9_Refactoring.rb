ruby_is_eloquent = true
ruby_is_ugly = false

puts "Ruby is eloquent!" if ruby_is_eloquent
puts "Ruby's not ugly!" unless ruby_is_ugly

 # ________________________________________________ternary conditional expression.

# 			boolean ? Do this if true: Do this if false

puts 3 < 4 ? "3 is less than 4!" : "3 is not less than 4."

language = "Python"

case language
when "JS"
  puts "Websites!"
when "Python"
  puts "Science!"
when "Ruby"
  puts "Web apps!"
else
  puts "I don't know!"
end

# ________________________________________________But you can fold it up like so:

case language
  when "JS" then puts "Websites!"
  when "Python" then puts "Science!"
  when "Ruby" then puts "Web apps!"
  else puts "I don't know!"
end


# ________________________________________________conditional assignment operator: ||=.
puts "_____________________________________________conditional assignment operator: ||="


favorite_book = nil
puts favorite_book

favorite_book ||= "Cat's Cradle"
puts favorite_book

favorite_book ||= "Why's (Poignant) Guide to Ruby" # => Cat's Cradle тк уже есть значение != nil
puts favorite_book

favorite_book = "Why's (Poignant) Guide to Ruby"
puts favorite_book

# ________________________________________________Implicit Return
# Powerful stuff!

def multiple_of_three(n)
   n % 3 == 0 ? "True" : "False"
end

# ________________________________________________Short-Circuit Evaluation
puts "_____________________________________________Short-Circuit Evaluation"


def a
  puts "A was evaluated!"
  return true
end

def b
  puts "B was also evaluated!"
  return true
end

puts a || b
puts "------"
puts a && b




# Well,.respond_to? takes a symbol and returns true if an object can receive that method and false 
# otherwise.


puts "_____________________________________________RESPOND_TO"
age = 26

# Add your code below!
puts 4.next

puts age.respond_to? (:next)


puts "_____________________________________________<< AND +"

# You can always use plain old + or << to add a variable value into a string:

drink = "espresso"
"I love " + drink
# ==> I love espresso
"I love " << drink
# ==> I love espresso


# But if you want to do it for non-string values, you have to use .to_s to make it a string:

age = 26
"I am " + age.to_s + " years old."
# ==> "I am 26 years old."
"I am " << age.to_s << " years old."
# ==> "I am 26 years old."


# This is complicated, and complicated is not the Ruby way. A better way to do this is with 
# string interpolation. The syntax looks like this:

"I love #{drink}."
# ==> I love espresso.
"I am #{age} years old."
# ==> I am 26 years old.

puts "_____________________________________________final programm"

$VERBOSE = nil    # We'll explain this at the end of the lesson.
require 'prime'   # This is a module. We'll cover these soon!

def first_n_primes(n)
    return "n must be an integer." unless n.is_a? Integer
    return "n must be greater than 0." if n <= 0
  prime_array ||= []
  prime = Prime.new
  n.times {prime_array << prime.next}
  prime_array
 end
first_n_primes(10)

=begin
If you remember, we had that weird-looking $VERBOSE = nil on line 1; this allowed us to use the old-style Prime.new from Ruby 1.8 without the interpreter yelling at us. In Ruby 1.9, we use Prime.instance instead, and the array magic is already built-in—we don't have to create prime_array or loop through it ourselves! (Then again, if we'd used .instance from the start, you wouldn't have gotten to do all that cool refactoring.)
=end
require 'prime'

def first_n_primes(n)
  # Check for correct input!
  "n must be an integer" unless n.is_a? Integer
  "n must be greater than 0" if n <= 0

  # The Ruby 1.9 Prime class makes the array automatically!
  prime = Prime.instance
  prime.first n
end

first_n_primes(10)
