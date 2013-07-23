person = "Tim"
puts "The object in 'person' is a #{person.class}"
puts "The object has an id of #{person.object_id}"
puts "and a value of '#{person}'"
=begin
On the first line, Ruby creates a new string object with the value Tim. A reference to this object
is placed in the local variable person.
So, is a variable an object? In Ruby, the answer is “no.” A variable is simply a reference to
an object.
=end
#---------------------------------------------------
person1 = "Tim"
person2 = person1
person3 = person1.dup 		# COpy
person4 = person3.freeze	# prevent modifications to the object
person1[0] = 'J'
person3[2] = 'o'
puts "person1 is #{person1}"
puts "person2 is #{person2}"
puts "person3 is #{person3}"
#---------------------------------------------------
# What happened here? We changed the first character of person1, but both person1 and person2
# changed from Tim to Jim.


# everything you manipulate in Ruby is an object and that objects start life as instances of classes.
