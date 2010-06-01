
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

# A class representing the player's ship moving in "space".
module LineMoving
  include Sprites::Sprite
  include EventHandler::HasEventHandler
  
  MOVING_KEYS = {
    :left => [:left, :a], 
    :right => [:right, :d], 
    :up => [:up, :w], 
    :down => [:down, :s]
  }
  
  attr_accessor :key
  
  def initialize_moving(max_speed = 100, accel = 1000, slowdown = 1000, *options)
    bind(MOVING_KEYS)  
    @vx, @vy = 0, 0 # Current Velocity
    @ax, @ay = 0, 0 # Current Acceleration
    
    # Max speed on an axis
    # Max Acceleration on an axis
    # Deceleration when not accelerating
    @max_speed, @accel, @slowdown = max_speed, accel, slowdown    
    
    @key = :none 
  end
    
  def moving_hooks!
    # Create event hooks in the easiest way.
    make_magic_hooks(
      KeyPressed => :start_moving,
      KeyReleased => :end_moving,    
      ClockTicked => :update_moving      
    )
  end
  
  def bind( moving_keys )
    @moving_keys = moving_keys
  end
  
  def moving_keys
    @moving_keys
  end

  # Update the ship state. Called once per frame.
  def update_moving( event )
    dt = event.seconds # Time since last update
    
    update_accel
    update_vel( dt )
    update_pos( dt )    
  end
  
  private
  
  def moving_key?( key )
    moving_keys.values.flatten.include? key rescue false
  end
  
  def vector?( key, vector ) #TODO: make new class Events::Key?
    moving_keys[vector].include?( key ) rescue false
  end
  
  # Add it to the list of keys being pressed.
  def start_moving( event )  
    @key = event.key if moving_key?(event.key)
    Sound['stay.ogg'].stop

    Sound['ride.ogg'].volume = 0.3
    Sound['ride.ogg'].play
  end
  
  # Remove it from the list of keys being pressed.
  def end_moving( event )
    @key = :none if moving_key?(event.key) and event.key == @key
    Sound['ride.ogg'].stop
    Sound['stay.ogg'].volume = 0.3
    Sound['stay.ogg'].play :repeats => -1
  end
  
  # Update the acceleration based on what keys are pressed.
  def update_accel
    x, y = 0,0    
    
    x -= 1 if vector?(@key, :left)
    x += 1 if vector?(@key, :right)
    y -= 1 if vector?(@key, :up)
    y += 1 if vector?(@key, :down) 

    # Scale to the acceleration rate. This is a bit unrealistic, since
    # it doesn't consider magnitude of x and y combined (diagonal).
    x *= @accel
    y *= @accel
        
    @ax, @ay = x, y    
  end
  
  
  # Update the velocity based on the acceleration and the time since
  # last update.
  def update_vel( dt )
    @vx = update_vel_axis( @vx, @ax, dt )
    @vy = update_vel_axis( @vy, @ay, dt )
  end
  
  
  # Calculate the velocity for one axis.
  # v = current velocity on that axis (e.g. @vx)
  # a = current acceleration on that axis (e.g. @ax)
  #
  # Returns what the new velocity (@vx) should be.
  #
  def update_vel_axis( v, a, dt )
    
    # Apply slowdown if not accelerating.
    if a == 0
      if v > 0
        v -= @slowdown * dt
        v = 0 if v < 0
      elsif v < 0
        v += @slowdown * dt
        v = 0 if v > 0
      end
    end
    
    # Apply acceleration
    v += a * dt
    
    # Clamp speed so it doesn't go too fast.
    v = @max_speed if v > @max_speed
    v = -@max_speed if v < -@max_speed
    
    return v
  end
  
  
  # Update the position based on the velocity and the time since last
  # update.
  def update_pos( dt )
    old_x = @px
    old_y = @py

    px = @px + (@vx * dt)
    py = @py + (@vy * dt)

    if py - (rect.h/2) > 0 and
        py < parent.h - (rect.h/2) and
        px - (rect.w/2) > 0 and
        px < parent.w - (rect.w/2)
      then
      
      @px += @vx * dt
      @py += @vy * dt

      rect.center = [@px, @py]
    end

    obstructions = Tanks.runner.objects.select do |obj|
      obj.is_a?(Obstruction) && obj.rect.inflate(-1,-1).collide_rect?(rect)
    end

    unless obstructions.empty?
      @px, @py = old_x, old_y
      rect.center = [@px, @py]
    end

  end
  public :update_pos
    
end

