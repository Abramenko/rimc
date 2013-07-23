# A good rule of thumb is never to expose methods that could leave an object in an invalid state.

=begin
Ruby gives you three levels of protection:
• Public methods can be called by anyone—no access control is enforced. Methods are
public by default (except for initialize, which is always private).
• Protected methods can be invoked only by objects of the defining class and its subclasses.
Access is kept within the family.
• Private methods cannot be called with an explicit receiver—the receiver is always the
current object, also known as self. This means that private methods can be called only in
the context of the current object; you can’t invoke another object’s private methods.


If a method is protected, it may be called by any instance of the
defining class or its subclasses. If a method is private, it may be called only within the context
of the calling object—it is never possible to access another object’s private methods directly,
even if the object is of the same class as the caller.


Access control is determined
dynamically, as the program runs, not statically. You will get an access violation only when the
code attempts to execute the restricted method.
=end


=begin
You specify access levels to methods within class or module definitions using one or more of the
three functions 
				public, protected, and private.
=end

class MyClass
	def method1
	  #...
	end
		# default is 'public'
	
	protected # subsequent methods will be 'protected'
	  def method2 # will be 'protected'
	    #... 
	  end 

	private # subsequent methods will be 'private'
	  def method3 # will be 'private'
	    #... 
	  end 

	public 
	  def method4 
	    #... 
	  end 
end 


# Alternatively

class MyClass
	def method1
	end
	def method2
	end
	# ... and so on
	
	public :method1, :method4
	protected :method2
	private :method3	
end

