
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

require "lib/acts/line_moving"
require "lib/acts/bomb_shooting"

module Tanks
  
  class Tank < GObject
    include LineMoving
    include BombShooting
    
    attr_accessor :vector, :screen, :x, :y
  
    GUN_HEIGHT = 15
    GUN_WIDTH = 6

    HP = 200

    def initialize( parent, cx, cy )

      super(parent, :center => [cx, cy])
      
      @px, @py = cx, cy
      

      @original = @image
      
      set_vector(:up)
            
      initialize_moving 100
      initialize_shooting(300.0, rect.center)
    end

    def hit
      100
    end

    def delete?
      false
    end
  
    def hooks!
      shooting_hooks!
      moving_hooks!
      
      hooks = {
        KeyPressed => :vector_handler
      }
      make_magic_hooks(hooks)
    end
        
    def set_vector( key )
      @vector = key if [:left, :right, :up, :down].include? key
    end

    def updated_vector
      puts @vector
    end

    def spin
      center = @rect.center
      @dizzy += 90			# increment angle
      if @dizzy >= 360		# if we have spun full-circle, stop spinning.
        @dizzy = 0
        @image = @original
      else					# otherwise, spin some more!
        # Note that we rotate with @original, not the current @image.
        # This reduces cumulative blurring from the rotation process,
        # and is just as efficient as incremental rotations.
        @image = @original.rotozoom(@dizzy,1,true)
      end
      @rect = image.make_rect()
      @rect.center = center # re-center
    end

    def update
      center = @rect.center

      case @vector
      when :left
        @image = @original.rotozoom(90, 1, true)

      when :right
        @image = @original.rotozoom(270, 1, true)

      when :up
        @image = @original.rotozoom(0, 1, true)

      when :down
        @image = @original.rotozoom(180, 1, true)

      end

      @rect = image.make_rect()
      @rect.center = center # re-center
    
      shooting_set_position(@rect.center.map{|a| a-3 })
    end
    
    private
    
    # Add it to the list of keys being pressed.
    def vector_handler( event )
      set_vector( event.key )
    end

  end


end