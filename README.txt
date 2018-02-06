#Spellchecker using a bloom filter to identify mispelled words (instead of crawling through the whole 3.4e6 dictionary every time or loading the whole mess into memory). Inspiration and wordlist acquired from Dave Thomas's CodeKata 05 here: http://codekata.com/kata/kata05-bloom-filters/

#We need:
# 1. Wordlist number of items "n"
# 2. Bitmap size "m" starting at 0 for every value then set to 1 on any hash selection.
# 3. k=(m/n)ln2 hash functions
# 4. Method of mapping hash function results to filter indices with uniform random distribution.

#Bitmap length and number of hash function ideal requirements are each solely dependent on the number of values being loaded to the filter and the desired false positive probability. We've adapted the statistical functions to calculate these in the snippet below (also copied into main for easy uncomment and run).

#(input => 0.000001, 338882)
#print "Input desired probability: " 
#p = gets.chomp.to_f 
#print "Input number of values to be loaded into the filter: "
#n = gets.chomp.to_i
#puts "Optimal bitmap size: " + "#{m = (-(n*Math.log(p))/(Math.log(2)**2)).ceil}"
#puts "Needed hash functions: " + "#{k= -(Math.log(p)/Math.log(2)).ceil}"

#Bitmap requirements range from 4,872,306 for a 0.001 false positive probability (1 in every 1000 'nonwords' yields 1 false positive) to 25,985,631 bits for a 1.0e-16 (femtoscopic) false positive probability. 

#We'll settle for a 1.0e-6 chance using a bitmap with 9,744,612 bits and 19 hash functions