require_relative "BloomFilter"

filter = BloomFilter.new(9744612, 19)

filter.loadDictionary("dict.txt")

choice = nil
puts "Spell checking is case sensitive."
puts "Enter \"quit\" to exit."
while choice != "quit" do
  print "Spell a word: "
  choice = gets.chomp
  if filter.validateHashIndices(choice)
    puts "That word is spelled correctly!"
  else
    puts "That word isn't spelled right!"
  end  
end

#print "Input desired probability: " 
#p = gets.chomp.to_f 
#print "Input number of values to be loaded into the filter: "
#n = gets.chomp.to_i
#puts "Optimal bitmap size: " + "#{m = (-(n*Math.log(p))/(Math.log(2)**2)).ceil}"
#puts "Needed hash functions: " + "#{k= -(Math.log(p)/Math.log(2)).ceil}"