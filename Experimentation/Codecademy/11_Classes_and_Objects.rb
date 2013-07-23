# Instance variables begin with an @. This isn't just a Ruby convention—it's part of the syntax! Always start your instance variables with @.

# Class variables are like instance variables, but instead of belonging to an instance of a class, 
# they belong to the class itself. Class variables always start with two @s, like so: @@files.

class Computer
  $manufacturer = "Mango Computer, Inc."
  @@files = {hello: "Hello, world!"}
  
  def initialize(username, password)
    @username = username
    @password = password
  end
  
  def current_user
    @username
  end
  
  def self.display_files
    @@files
  end
end

# Make a new Computer instance:
hal = Computer.new("Dave", 12345)

puts "Current user: #{hal.current_user}"
# @username belongs to the hal instance.

puts "Manufacturer: #{$manufacturer}"
# $manufacturer is global! We can get it directly.

puts "Files: #{Computer.display_files}"
# @@files belongs to the Computer class.

# Global variables can be declared in two ways. The first is one that's already familiar to you: 
# you just define the variable outside of any method or class, and voilà! It's global. If you want 
# to make a variable global from inside a method or class, just start it with a $, like so: $matz.

# Class variable shared by all instances of a class

# For example, we can use a class variable to keep track of the number of instances of that class we've created.
class Person
  # Set your class variable to 0 on line 3
  @@people_count = 0
  
  def initialize(name)
    @name = name
    # Increment your class variable on line 8
    @@people_count += 1
  end
  
  def self.number_of_instances
    # Return your class variable on line 13
    return @@people_count
  end
end

matz = Person.new("Yukihiro")
dhh = Person.new("David")

puts "Number of Person instances: #{Person.number_of_instances}"