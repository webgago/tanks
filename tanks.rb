require "config/environment"

begin

  Game.autoload_resources!("resources")

  # Start the main game loop. It will repeat forever
  # until the user quits the game!
  Game.run do |runner|
    center_x = runner.screen.w/2
    center_y = runner.screen.h/2

    map = File.join(Game.dir, "resources", "1.map")
    puts "map: #{map}"

    File.open(map) do |f|
      f.each_line do |line|
        charno = 0
        line.each_char do |c|
          left = charno * 60
          top = f.lineno * 60
          case c
          when /W/
            puts "<Wall left=#{left} top=#{top}>"
            runner.objects << Wall.new(runner.screen, top, left, 60, 60)

          when /T/
            puts "<Tank left=#{left} top=#{top}>"
            tank = Tank.new( runner.screen, top, left, 30, 30 )
            tank.hooks!
            runner.objects << tank
            runner.make_magic_hooks_for( tank, { YesTrigger.new() => :handle } )
          when /\s/
            
          end
          charno += 1
        end
      end
    end

    #tank = Tank.new( runner.screen, center_x, center_y, 60, 60 )
    #tank.hooks!
    
    #bot = Tank.new( runner.screen, center_x-200, center_y+50, 60, 60 )
    #bot.tower_color!(:red)
    #bot.bot!

    #runner.objects << tank
    #runner.objects << bot

    #runner.objects << Wall.new(runner.screen, 0, 0, 60, 60)
    #runner.objects << Wall.new(runner.screen, 60, 0, 60, 60)
    #runner.objects << Wall.new(runner.screen, 120, 60, 60, 60)
    #runner.objects << Wall.new(runner.screen, 180, 60, 60, 60)
    #runner.objects << Wall.new(runner.screen, 180, 120, 60, 60)
    #runner.objects << Wall.new(runner.screen, 180, 180, 60, 60)

    # Make event hook to pass all events to ship#handle().
    #runner.make_magic_hooks_for( tank, { YesTrigger.new() => :handle } )
    #runner.make_magic_hooks_for( bot, { YesTrigger.new() => :handle } )

  end

ensure
  Rubygame.quit()
end
