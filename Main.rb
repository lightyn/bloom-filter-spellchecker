require_relative "BloomFilter"

filter = BloomFilter.new(9744612, 29)

filter.loadDictionary("dict.txt")
filter.hasValue?("cookie")


filter.hasValue?("aksjfagkjbgk")
filter.hasValue?("air")
filter.hasValue?("albatrosd")

print "Input desired probability: " 
p = gets.chomp.to_f 
print "Input number of values to be loaded into the filter: "
n = gets.chomp.to_i
puts "Optimal bitmap size: " + "#{m = (-(n*Math.log(p))/(Math.log(2)**2)).ceil}"
puts "Needed hash functions: " + "#{k= -(Math.log(p)/Math.log(2)).ceil}"