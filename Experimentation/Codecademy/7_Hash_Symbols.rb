=begin
Along with false, nil is one of two non-true values in Ruby. (Every other object is regarded as "truthy," meaning that if you were to type if 2 or if "bacon", the code in that if statement would be run.)
=end



# Converting between strings and symbols is a snap. You can convert a symbol to a string with
# the .to_s method:

			:sasquatch.to_s # ==> "sasquatch"

# And you can convert a string to a symbol with the .to_sym method:

			"sasquatch".to_sym # ==> :sasquatch

# ---------------------------------------------------------------------
strings = ["HTML", "CSS", "JavaScript", "Python", "Ruby"]

# Add your code below!

symbols = Array.new
strings.each {|a| symbols.push (a.to_sym)}



# Besides using .to_sym, you can also use .intern. This will internalize the string into a symbol 
# and works just like .to_sym:

"hello".intern
# ==> :hello

puts "____________________________________________________string VS symbol"
require 'benchmark'

string_AZ = Hash[("a".."z").to_a.zip((1..26).to_a)]
symbol_AZ = Hash[(:a..:z).to_a.zip((1..26).to_a)]

string_time = Benchmark.realtime do
  100_000.times { string_AZ["r"] }
end

symbol_time = Benchmark.realtime do
  100_000.times { symbol_AZ[:r] }
end

puts "String time: #{string_time} seconds."
puts "Symbol time: #{symbol_time} seconds."

puts "____________________________________________________.SELECT"
# The .select method takes a block consisting of a key/value pair and an expression for selecting 
# matching keys and values. Here are some examples:

grades = { alice: 100,
  bob: 92,
  chris: 95,
  dave: 97
}

grades.select { |k,v| k > :c }
# ==> {:chris=>95, :dave=>97}

grades.select { |k,v| v < 97 }
# ==> {:bob=>92, :chris=>95}

puts "___________________________________________________________"
# Ruby includes two hash methods, .each_key and .each_value, that do exactly what you'd expect:

my_hash = { one: 1, two: 2, three: 3 }

my_hash.each_key { |k| print k, " " }
# ==> one two three

my_hash.each_value { |v| print v, " " }
# ==> 1 2 3

