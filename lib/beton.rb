class Beton < Wall

  HP = Infinity

  def initialize( screen, top, left)
    @screen = screen

    @image = Surface['beton.png']

    @rect = @image.make_rect
    @rect.top = top
    @rect.left = left
    @hp = Infinity
  end
  
end
