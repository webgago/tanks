require "rubygems"
require "rubygame"

require "lib/game"
require "lib/font"

# Import the Rubygame module into the current namespace, so that you can
# type "Surface" instead of "Rubygame::Surface", etc.
include Rubygame
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers
include EventHandler::HasEventHandler
    
Game.autoload_resources!

require "lib/ship"
require "lib/game/runner"

