 print "Print, please:"
    user_input = gets.chomp
    user_input.downcase!

while user_input == nil
    print "Print, please:"
    user_input = gets.chomp
    user_input.downcase!
end

if user_input.include? "s"
    user_input.gsub!(/s/,"th")
else
    print "OK"
end

puts "You typed #{user_input}"
