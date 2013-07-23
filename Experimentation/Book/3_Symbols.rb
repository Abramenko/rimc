=begin
	Symbols are simply constant names that you don’t have to
	predeclare and that are guaranteed to be unique.

	walk(:north)
	

	def walk(direction)
	  if direction == :north
	  # ...
	end
	end
=end

inst_section = {
	:cello => 'string',
	:clarinet => 'woodwind',
	:drum => 'percussion',
	:oboe => 'woodwind',
	:trumpet => 'brass',
	:violin => 'string'
	}

	p inst_section[:oboe] # => "woodwind"
	p inst_section[:cello] # => "string"
# Note that strings aren't the same as symbols...
	p inst_section['cello'] # => nil

=begin
In fact, symbols are so frequently used as hash keys that Ruby 1.9 introduces a new syntax—you
can use name: value pairs to create a hash if the keys are symbols:
=end

inst_section = {
cello:		'string',
clarinet:	'woodwind',
drum:		'percussion',
oboe:		'woodwind',
trumpet:	'brass',
violin:		'string'
}
puts "An oboe is a #{inst_section[:oboe]} instrument"
