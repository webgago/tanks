class Wall
  include Sprites::Sprite
  include EventHandler::HasEventHandler
  include Destroyable
  include Obstruction

  HP = 200

  def initialize( screen, top, left )
    @screen = screen
    #@px, @py = px, py # Current Position

    # The ship's appearance. A white square for demonstration.
    @image = Surface['wall.png']

    @rect = @image.make_rect
    @rect.top = top
    @rect.left = left
    @hp = 200
  end

  def update
    
  end

  def hit
    @hp = @hp - (HP * 1) rescue @hp = HP - (HP * 1)
  end

  def delete?
    @hp == 0 or @hp < 0
  end

  
end
