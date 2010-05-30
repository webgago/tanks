module Destroyable
end

module Obstruction
end

Infinity = 1.0/0

require "rubygems"
require "rubygame"

Rubygame.enable_key_repeat 0.5, 0.5

require "lib/game"
require "lib/font"

# Import the Rubygame module into the current namespace, so that you can
# type "Surface" instead of "Rubygame::Surface", etc.
include Rubygame
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers
include EventHandler::HasEventHandler
    
require "lib/bomb"
require "lib/tank"
require "lib/wall"
require "lib/beton"
require "lib/game/runner"

