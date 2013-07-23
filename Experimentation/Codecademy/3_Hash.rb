 puts "Text to Search"
    text = gets.chomp
    
    puts "Word to Redact:"
   
    redact = gets.chomp
    
    
  
    
    word = text.split (" ")
    text = " "
   word.each do |a|
        if a.upcase != redact.upcase
            print a + " "
             text = text + a + " "
        else
            print "REDACTED" + " "
            text = text + "REDACTED" + " "
        end
    end
    puts text
