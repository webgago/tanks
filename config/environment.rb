require "rubygems"
require "rubygame"

require "lib/game"
require "lib/font"

# Import the Rubygame module into the current namespace, so that you can
# type "Surface" instead of "Rubygame::Surface", etc.
include Rubygame
 

Game.autoload_resources!
