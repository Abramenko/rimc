# Inheritance 

# Inheritance is the process by which one class takes on the attributes and methods of another

# In Ruby, inheritance works like this:

class Application
  def initialize(name)
    @name = name
  end
end

class MyApp < Application

end 

# Override!

class Creature
  def initialize(name)
    @name = name
  end
  
  def fight
    return "Punch to the chops!"
  end
end

class Dragon < Creature
  def fight
    return "Breathes fire!"
  end
end

# You can directly access the attributes or methods of a SUPERCLASS (or perent) with Ruby's built-in super keyword.

=begin
	When you call super from inside a method, that tells Ruby to look in the superclass of the current class and find
	a method with the same name as the one from which super is called. If it finds it, Ruby will use the superclass' 
	version of the method.	
=end


# !Any given Ruby class can have only one superclass. 

# However, there are instances where you want to incorporate data or behavior from several classes 
# into a single class, and Ruby allows this through the use of mixins. 


# if you want to end a Ruby statement without going to a new line, you can just type a semicolon.

class Dragonto < Creature; end

class Message
	@@messages_sent = 0

	def initialize(from, to)
		@from = from
		@to = to
		@@messages_sent += 1 # when we created new message
	end
end

my_message = Message.new("Alexander Abramenko","Anton Repjov")

class Email < Message
	def initialize(subject)
		super("Alexander Abramenko","Anton Repjov")
	end
end