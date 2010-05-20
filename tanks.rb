require "config/environment"


# Start the main game loop. It will repeat forever
# until the user quits the game!
Game.run do |runner|
  ship = Ship.new( runner.screen, runner.screen.w/2, runner.screen.h/2 )
  runner.objects << ship  
  # Make event hook to pass all events to ship#handle().
	runner.make_magic_hooks_for( ship, { YesTrigger.new() => :handle } )
end

# Make sure everything is cleaned up properly.
Rubygame.quit()