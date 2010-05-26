include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

# A module representing the bomb shooting logic.
module BombShooting
  
  def initialize_shooting(bomb_speed = 300.0, position = [0,0])
    @bombs = []
    @bomb_speed = bomb_speed
    @position = position
    
    # Create event hooks in the easiest way.
    hooks = { 
      ClockTicked => :update_bomb_positions
    }
    
    make_magic_hooks(hooks)        
  end
  
  def shooting_hooks!
    hooks = { 
      KeyPressed => :shoot_handler,
      MousePressed  => :shoot, 
    }
      
    make_magic_hooks(hooks)
  end
    
  def faster_mod
    @faster = if !@faster
      Rubygame.enable_key_repeat 0.5, 0.1 
      true
    elsif @faster
      Rubygame.enable_key_repeat 0.5, 0.5 
      false
    end  
  end
  
  def shooting_set_position(position = [0,0])    
    @position = position
  end
  
  def shoot
    @bombs << Bomb.new(@screen, @position, @vector )
    play_sound
  end
  
  private
  
  def shoot_handler( event )
    faster_mod if event.key == :x 
    shoot if [:space, :x].include? event.key
  end
    
  def update_bomb_positions(event)
    return if @bombs.empty?
    
    dt = event.seconds
    
    @bombs.each do |bomb|
      bomb.move(dt * @bomb_speed)
           
      if bomb.delete?
        @bombs.delete(bomb)
      else
        bomb.draw
      end        
    end  
  end
  
  def play_sound
    rand_num = [1,2,3,4].shuffle.first
    name = "MoteAbsorb#{rand_num}.ogg"
    Sound[name].play rescue puts "Ooops! File #{name} does not exists!"
  end
  
  class Bomb
    include Sprites::Sprite
    
    attr_accessor :surface, :rect
    attr_accessor :x, :y, :vector
    
    def initialize(parent, center, vector)      
      @parent = parent
      
      @surface = Surface.new([5,5])
      @surface.fill(:red)
      @rect = @surface.make_rect
      
      @x, @y = center
      @vector = vector
    end  
    
    def delete?
      @y < 0 or @y > @parent.h or 
      @x < 0 or @x > @parent.w        
    end
    
    def draw
      @surface.blit(@parent, [ @x, @y ])      
    end
    
    def move(pos)
      case vector
      when :up
        move_up(pos)
        
      when :down
        move_down(pos)
        
      when :left 
        move_left(pos)
        
      when :right
        move_right(pos)
      end
    end
    
    def move_up(px)
      @y -= px  
    end
    
    def move_down(px)
      @y += px  
    end
    
    def move_left(px)
      @x -= px
    end
    
    def move_right(px)
      @x += px  
    end
    
  end
  
end
