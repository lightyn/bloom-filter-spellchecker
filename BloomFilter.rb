require 'digest'

class BloomFilter 
  @bitmap
  @numberOfHashFunctions
  @hashIndex
  @seedIndex
 
  def initialize(bitmapLength, numberOfHashFunctions)
    @bitmap = []
    for i in 0...bitmapLength
      @bitmap[i] = 0 
    end
    @numberOfHashFunctions = numberOfHashFunctions
    @hashIndex = nil
    @seedIndex = nil
  end

  #Loads a new-line delimited list of values to add to the filter from file without opening the whole file.
  def loadDictionary(path)
    File.readlines(path).each do |line|
      loadValue(line.chomp!)
    end
  end
  
  #This is a little bit of code salad that essentially takes the input value, generates a SHA256 hash from it, converts it to an integer, ensures the int is positive, and then returns it.
  def hashValueToInt(value)
    return Digest::SHA256.digest(value).unpack('q').first.abs
  end 

  
  #We'll use this method to either validate values against the filter, or to set it, depending on the block we pass in. The double hash algorithm we're using is adapted from Dillinger and Manilios' bitstate verification research located here: 
  #http://homedirs.ccs.neu.edu/pete/pub/spin-3spin.pdf
  def getHashIndices(value)
    #For the first hash function we'll just use the lookup value (we have to convert the value to string first because SHA256.digest requires a string input)
    @hashIndex = hashValueToInt(value.to_s)%@bitmap.length
    yield
    #On the second, let's salt it.
    @seedIndex = hashValueToInt(value.to_s+'haveSomeSalt')%@bitmap.length
    #Now let's do some math to get the rest of the indices.
    i = 1 
    while (i<@numberOfHashFunctions) do
      @hashIndex = (@hashIndex+@seedIndex)%@bitmap.length
      yield
      i += 1
    end
  end
  
    
  def loadValue(value)
    getHashIndices(value) do 
      @bitmap[@hashIndex] = 1
    end
  end
  
  def validateHashIndices(value)
    getHashIndices(value) do
      if @bitmap[@hashIndex] != 1
        return false
      end
    end
    true
  end
  
  
  #Debugging tools
  def hasValue?(value)
    puts validateHashIndices(value)
  end
  
  def dumpBitmap
    print @bitmap
    puts
  end
end

      
    
    
    
    
    
    