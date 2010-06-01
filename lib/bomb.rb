module Tanks

  class Bomb < GObject
    attr_accessor :surface
    attr_accessor :x, :y, :vector

    def initialize(parent, center, vector)
      super(parent, :center => center)
      
      @x, @y = rect.center
      @vector = vector
      @deleted = false

      case vector
      when :up
        @image = @image.rotozoom(270, 1, true)

      when :down
        @image = @image.rotozoom(90, 1, true)

      when :left
        @image = @image.rotozoom(0, 1, true)

      when :right
        @image = @image.rotozoom(180, 1, true)

      end

    end

    def delete?
      @deleted or
        @y < 0 or @y > @parent.h or
        @x < 0 or @x > @parent.w
    end

    def draw
      @image.blit(@parent, [ @x, @y ])
      update
    end

    def update
      @rect.center = [@x, @y]

      Tanks.runner.objects.each do |obj|
        next unless obj.is_a? Destroyable

        if obj.collide_sprite?(self)
          obj.hit
          @deleted = true
          Sound['boom.ogg'].volume = 0.3
          Sound['boom.ogg'].play
        end
      end
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