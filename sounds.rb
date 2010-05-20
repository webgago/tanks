module A
  
  attr_accessor :a
  
  # Initialize the Sprite, defining @groups and @depth.
  def initialize(*params)    
		@a = 0
    puts params
	end
  
  def test
    if a == @a 
      puts "#{a} == #{@a}"
    else
      puts "Oops!"
    end
  end
  
end

class B
  include A
  
  def initialize(screen, *params)    
    super
    puts screen
  end
end