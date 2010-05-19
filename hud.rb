# Basic example of bliting some text on the screen
 
require 'rubygame'
 
# for convenience/readability.
include Rubygame
include Rubygame::Events
 
# A class representing the HUD
class Hud
 
  # construct the HUD
  def initialize options
    @screen = options[:screen]  # need that to blit on it
 
    # TTF.setup must be called before any font object is created
    TTF.setup
 
    # point to the TTF file
    filename = File.join(File.dirname(__FILE__), 'resources', 'fonts', 'SF Cosmic Age Condensed.ttf')
 
    # creates the font object, which is used for drawing text
    @cosmic_font = TTF.new filename, 48    
    # initialize options that are displayed, here time
    @time = "-"
 
  end
 
  # called from the game class in each loop. updates options that are displayed
  def update options
    @text = options[:time] || options[:text]
  end
 
  # called from the game class in the draw method. render any options 
  # and blit the surface on the screen
  def draw(margin = [0,0])
    timer = @cosmic_font.render @text, true, :pink
    timer.blit @screen, [(@screen.w-timer.w-margin[0])/2, (@screen.h-timer.h-margin[1])/2]   # blit to upper right corner
  end
 
end