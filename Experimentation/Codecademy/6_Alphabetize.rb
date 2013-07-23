def alphabetize(arr,rev=false)
  if rev == true
    arr.sort! {|a ,b| -(a <=> b)}
  else
    arr.sort! {|a,b| a <=> b}
  end
end

p alphabetize(["b","a","c","f","d","e"])
p alphabetize(["b","a","c","f","d","e"], true)


#----------------------------------------------------



