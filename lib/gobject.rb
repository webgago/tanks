module Tanks

  class GObject
    include Sprites::Sprite
    include EventHandler::HasEventHandler

    attr_accessor :rect, :parent
    
    def initialize(parent, position)
      @parent = parent
      
      @image = Surface["#{self.class.to_s.split('::').last.downcase}.png"]

      @rect = @image.make_rect

      set_position(position)
    end


    private

    def set_position(position = {})

      position.each_pair do |method, value|
        method = "#{method.to_s}=".to_sym
        rect.send(method, value) if rect.respond_to?(method)
      end

#      rect.center = options[:center] if options[:center]
#      rect.bottomleft = options[:bottomleft] if options[:bottomleft]
#      rect.bottomright = options[:bottomright] if options[:bottomright]
#      rect.topleft = options[:topleft] if options[:topleft]
#      rect.topright = options[:topright] if options[:topright]
#
#      rect.top = options[:top] if options[:top]
#      rect.left = options[:left] if options[:left]
#      rect.bottom = options[:bottom] if options[:bottom]
#      rect.right = options[:right] if options[:right]
#      rect.centerx = options[:centerx] if options[:centerx]
#      rect.centery = options[:centery] if options[:centery]
    end

  end

end





