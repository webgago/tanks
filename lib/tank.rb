
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

require "lib/acts/line_moving"
require "lib/acts/bomb_shooting"

# A class representing the player's ship moving in "space".
class Tank
  include Sprites::Sprite
  include EventHandler::HasEventHandler
  include LineMoving
  include BombShooting
    
  attr_accessor :vector, :screen, :x, :y
  attr_accessor :gun_color, :tower_color, :body_color
  
  GUN_HEIGHT = 15
  GUN_WIDTH = 6
    
  def initialize( screen, px, py, w, h )
    @screen = screen
    @px, @py = px, py # Current Position
      
    # The ship's appearance. A white square for demonstration.
    @image = @tank = Surface.new([w+GUN_HEIGHT*2, h+GUN_HEIGHT*2])
    @image.fill([0,0,0,0.0])
      
    @body = Surface.new([w,h])
    @body.fill(body_color || :white)
    @rect = @image.make_rect
    @rect.top = @px
    @rect.left = @py

    set_vector(:up)
            
    @gun = Surface.new([GUN_WIDTH, GUN_HEIGHT])
    @gun.fill(gun_color || :gray)
      
    @tower = Surface.new([20,20])
    @tower.fill(tower_color || :green)


    @bot = false
    
    initialize_moving
    initialize_shooting(300.0, @gun.make_rect.center)
  end

  
  
  def gun_color!(color)
    @gun.fill(color)
    @gun_color = color
  end
    
  def tower_color!(color)
    @tower.fill(color)
    @tower_color = color
  end
    
  def body_color!(color)
    @body.fill(color)
    @body_color = color
  end
    
  def hooks!
    shooting_hooks!
    moving_hooks!
      
    hooks = {
      KeyPressed => :vector_handler
    }
    make_magic_hooks(hooks)
  end
    
  def bot!
    @key = :up
    @bot = true
  end

  def bot?
    @bot
  end

  def bot_update( event )
    
  end
    
  def set_vector( key )
    @vector = key if [:left, :right, :up, :down].include? key
  end

  def updated_vector
    puts @vector
  end

  def update

  end
  
  def draw(screen)
    super
      
    shooting_set_position([ @rect.center[0]-GUN_WIDTH/2, @rect.center[1]-GUN_WIDTH/2 ])
      
    @image.fill([0,0,0,0.0])
      
    draw_body
    draw_tower
    draw_gun
  end
    
  private
    
  def draw_body
    @body.fill(body_color || :white)
    @body.blit(@image, [@image.w/2 - @body.w/2, @image.h/2 - @body.h/2])
  end
    
  def draw_tower
    @tower.blit(@image, [@image.w/2 - @tower.w/2, @image.h/2 - @tower.h/2])
    @tower.fill(tower_color || :green)
  end
    
  def draw_gun
    case @vector
    when :left
      @gun = @gun.zoom_to @gun.h, @gun.w if @gun.h > @gun.w
      @gun.blit(@image, [@image.w/2 - @gun.w*2+10, @image.h/2 - @gun.h/2])
        
    when :right
      @gun = @gun.zoom_to @gun.h, @gun.w if @gun.h > @gun.w
      @gun.blit(@image, [@image.w/2 + @gun.w/2+10, @image.h/2 - @gun.h/2])
        
    when :up
      @gun = @gun.zoom_to @gun.h, @gun.w if @gun.w > @gun.h
      @gun.blit(@image, [@image.w/2 - @gun.w/2, @image.h/2 - @gun.h*2+10])
        
    when :down
      @gun = @gun.zoom_to @gun.h, @gun.w if @gun.w > @gun.h
      @gun.blit(@image, [@image.w/2 - @gun.w/2, @image.h/2 + @gun.h/2+10])
    end
  end
    
  # Add it to the list of keys being pressed.
  def vector_handler( event )
    set_vector( event.key )
  end

end


