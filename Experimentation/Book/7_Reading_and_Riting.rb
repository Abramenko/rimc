
# output
print "hell"
puts "o"
printf("Number: %5.2d,\nString: %s\n", 1.23, "hello")

# input

line = gets 
print line

# Because gets returns nil when it reaches the end of input, you can use its return value in a loop
# condition

while line = gets
	print line
end
