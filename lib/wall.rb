
module Destroyable
end

module Obstruction
end

class Wall
  include Sprites::Sprite
  include EventHandler::HasEventHandler
  include Destroyable
  include Obstruction

  HP = 200

  def initialize( screen, top, left, w, h )
    @screen = screen
    #@px, @py = px, py # Current Position

    # The ship's appearance. A white square for demonstration.
    @image = @tank = Surface.new([w, h])
    @image.fill([255,155,0])

    @rect = @image.make_rect
    @rect.top = top
    @rect.left = left
    @hp = 200
  end

  def update
    
  end

  def hit
    @hp = @hp - (HP * 0.25) rescue @hp = HP - (HP * 0.25)
    puts "#{@hp}/#{HP}"
  end

  def delete?
    @hp == 0 or @hp < 0
  end

  
end
