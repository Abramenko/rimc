
=begin
	In Ruby, you typically create a regular expression by writing a pattern between slash
characters (/pattern/).And, Ruby being Ruby, regular expressions are objects and can be manip-
ulated as such

	example, you could write a pattern that matches a string containing the text Perl or the text. Python using the following regular expression:

				/Perl|Python/

	The forward slashes delimit the pattern, which consists of the two things we’re matching, separated by a pipe character (|). This pipe character means “either the thing on the right or the thing on the left,” in this case either Perl or Python. You can use parentheses within patterns, just as you can in arithmetic expressions, so you could also have written this pattern like this:


				/P(erl|ython)/

You can also specify repetition within patterns. /ab+c/ matches a string containing an a followed
by one or more b’s, followed by a c. Change the plus to an asterisk, and /ab*c/ creates a regular
expression that matches one a, zero or more b’s, and one c.


You can also match one of a group of characters within a pattern. Some common examples are
character classes such as \s, which matches a whitespace character (space, tab, newline, and
so on); \d, which matches any digit; and \w, which matches any character that may appear in a
typical word. A dot (.) matches (almost) any character. A table of these character classes appears
on page 118.

	/\d\d:\d\d:\d\d/# a time such as 12:34:5
	/Perl.*Python/	# Perl, zero or more other chars, then Python
	/Perl Python/	# Perl, a space, and Python
	/Perl *Python/	# Perl, zero or more spaces, and Python
	/Perl +Python/	# Perl, one or more spaces, and Python
	/Perl\s+Python/	# Perl, whitespace characters, then Python
	/Ruby (Perl|Python)/	# Ruby, a space, and either Perl or Python
=end 

# For example, the following code fragment writes a message if a string contains the text Perl or # Python:

	line = gets
	
	if line =~ /Perl|Python/
		puts "Scripting language mentioned: #{line}"
	end


# The part of a string matched by a regular expression can be replaced with different text using
# one of Ruby’s substitution methods:
	line = gets
	newline = line.sub(/Perl/, 'Ruby')
# replace first 'Perl' with 'Ruby'
	newerline = newline.gsub(/Python|Perl/, 'Ruby') # replace every 'Python'or'Perl'  with 'Ruby'
