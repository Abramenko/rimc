# First, parameters to a block are now always local to a block, even if they have the same name
# as locals in the surrounding scope.

value = "some shape"
[ 1, 2 ].each {|value| puts value }
puts value

# Second, you can now define block-local variables by putting them after a semicolon in the
# block’s parameter list. So, in our sum-of-squares example, we should have indicated that the
# square variable was block-local by writing it as follows:

square = "some shape"
sum = 0
[1, 2, 3, 4].each do |value; square|
square = value * value
# this is a different variable
sum += square
end
puts sum
puts square
