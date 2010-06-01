libdir = File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

Infinity = 1.0/0

require "rubygems"
require "rubygame"

Rubygame.enable_key_repeat 0.5, 0.5

require "game"
require "font"

# Import the Rubygame module into the current namespace, so that you can
# type "Surface" instead of "Rubygame::Surface", etc.
include Rubygame
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers
include EventHandler::HasEventHandler

require "gobject"
require "signs"
require "bomb"
require "tank"
require "wall"
require "beton"
require "game/runner"

