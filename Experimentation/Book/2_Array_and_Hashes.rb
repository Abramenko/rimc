#!/home/lodoss/.rvm/bin/ruby-1.9.2-p320

	a = [1,'cat',3.14]
	puts "The first element #{a[0]}"
# set the third element
	a[2] = nil
	puts "The array is now #{a.inspect}"
# %w insted of , , , 
	a = %w{ 'ant' 'bee' 'cat' 'dog' 'pop'}
	puts a[0] 
	puts a[4]
# hash
	inst = {
	'cello'		=>	'string',
	'clarinet'	=>	'woodwind',
	'drum'		=>	'percussion',
	'oboe'		=>	'woodwind',
	'trumpet'	=>	'brass',
	'violin'	=>	'string'
	}

	p inst['oboe']
	p inst['cello']
	p inst['bassoon']
# default value when you create a new, empty hash.
	histogram = Hash.new(0)
	# The default value is zero
	p histogram['ruby'] # => 0
	histogram['ruby'] = histogram['ruby'] + 1
	p histogram['ruby'] # => 1
