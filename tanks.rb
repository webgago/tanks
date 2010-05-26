require "config/environment"

begin

  Game.autoload_resources!("resources")

  # Start the main game loop. It will repeat forever
  # until the user quits the game!
  Game.run do |runner|
    tank = Tank.new( runner.screen, runner.screen.w/2, runner.screen.h/2, 60, 60 )
    tank.hooks!
    
    bot = Tank.new( runner.screen, (runner.screen.w/2)-200, (runner.screen.h/2)+50, 60, 60 )
    bot.tower_color!(:red)
    bot.bot!

    bot.instance_eval do
      def say
        puts self
      end
    end
    runner.objects << tank
    runner.objects << bot
  
    # Make event hook to pass all events to ship#handle().
    runner.make_magic_hooks_for( tank, { YesTrigger.new() => :handle } )
    runner.make_magic_hooks_for( bot, { YesTrigger.new() => :handle } )

    tank.make_magic_hooks(
      :left => bot.say,
      :right => bot.say,
      :up => bot.say,
      :down => bot.say
    )
  end

ensure
  Rubygame.quit()
end