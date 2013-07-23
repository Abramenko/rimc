# IF
	today = Time.now
	if today.saturday?
		puts "Do chores around the house"
	elsif today.sunday?
		puts "Relax"
	else
		puts "Go to work"
	end
# WHILE
	num_pallets = 101
	weight = 1

	while weight < 100 and num_pallets <= 30
		# ...
	end
# Most statements in Ruby return a value, which means you can use them as conditions.
# For example, the kernel method gets returns the next line from the standard input stream or nil # when the end of the file is reached.
# Because Ruby treats nil as a false value in conditions, you could
# write the following to process the lines in a file:
	
	while line = gets
		puts line.downcase
	end

=begin
Ruby statement modifiers are a useful shortcut if the body of an if or while statement is just a
single expression. Simply write the expression, followed by if or while and the condition.
=end

	puts "Danger, Will Robinson" if 2 < 3000

# or

	square = 4
	square = square*square while square < 1000

