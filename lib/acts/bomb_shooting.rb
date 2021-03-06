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
    
  def shooting_set_position(position = [0,0])    
    @position = position
  end
  
  def shoot
    @bombs << Tanks::Bomb.new(parent, @position, @vector )
    play_sound
  end
  
  private
  
  def shoot_handler( event )
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
    Sound["shoot.ogg"].volume = 0.3
    Sound["shoot.ogg"].play
  end
  
end
