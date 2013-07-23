print "What your first name?"
first_name = gets.chomp
first_name = first_name.capitalize

print "What your last name?"
last_name = gets.chomp
last_name = last_name.capitalize

print "What your city?"
city = gets.chomp
city = city.capitalize

print "What your state?"
state  = gets.chomp
state  = state.upcase

print "May be you are #{first_name} #{last_name} who live in #{city} #{state}"
