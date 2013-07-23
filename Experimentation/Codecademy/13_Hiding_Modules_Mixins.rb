module Circle

  PI = 3.14
  
  def Circle.area(radius)
    PI * radius**2
  end
  
  def self.circumference(radius)
    2 * PI * radius
  end
end

puts Math::PI
puts Circle::PI
# ----------------------
require 'date'

puts Date.today
#-----------------------

# A nice effect of this is that you no longer have to prepend your constants and
# methods with the module name; since everything has been pulled in, you can 
# simply write PI instead of Math::PI.

class Angle
  include Math
  attr_accessor :radians
  
  def initialize(radians)
    @radians = radians
  end
  
  def cosine
    cos(@radians)
  end
end

acute = Angle.new(1)
puts acute.cosine

# When a module is used to mix additional behavior and information into
# a class, it's called a mixin. Mixins allow us to customize a class 
# without having to rewrite code!

module Action
  def jump
    @distance = rand(4) + 2
    puts "I jumped forward #{@distance} feet!"
  end
end

class Rabbit
  include Action
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Cricket
  include Action
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

peter = Rabbit.new("Peter")
jiminy = Cricket.new("Jiminy")

peter.jump
jiminy.jump

# by mixing in traits from various modules as needed, we can add 
# any combination of behaviors to our classes we like!

#----------------------------------------------
# Whereas include mixes a module's methods in at the instance level 
# (allowing instances of a particular class to use the methods), 
# the extend keyword mixes a module's methods at the class level.
# This means that class itself can use the methods, as opposed to 
# instances of the class.

module ThePresent
  def now
    puts "It's #{Time.new.hour > 12 ? Time.new.hour - 12 : Time.new.hour}:#{Time.new.min} #{Time.new.hour > 12 ? 'PM' : 'AM'} (GMT)."
  end
end

class TheHereAnd
  extend ThePresent
end

TheHereAnd.now


#------------------------------------------------------------
# You probably also noticed we used underscores in our 1_000_000 
# (one million). Ruby allows this, and it makes it easier to read big 
# numbers! Cool, no?


class Account
  attr_reader :name, :balance
  def initialize(name, balance=100)
    @name = name
    @balance = balance
  end

  def display_balance(pin_number)
    puts pin_number == pin ? "Balance:$#{@balance} ": pin_error
  end

  def withdraw(pin_number, amount)
    if pin_number == pin
      @balance -= amount
      puts "Withdrew #{amount}. New balance: $#{@balance}."
    else
      pin_error
    end
  end

private
  def pin
    @pin = 1234
  end

  def pin_error
    "Access denied: incorrect PIN"
  end
end
