# When you run a Ruby program from the command line, you can pass in arguments. 

	puts "You gave #{ARGV.size} arguments"
	p ARGV

=begin
Often, the arguments to a program are the names of files that you want to process. In this case,
you can use a second technique: the variable ARGF is a special kind of I/O object that acts like
all the contents of all the files whose names are passed on the command line (or standard input
if you don’t pass any filenames). We’ll look at that some more on page 327.
=end

