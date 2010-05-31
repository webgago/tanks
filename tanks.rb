require "config/environment"

begin

  Game.autoload_resources!("resources")

  Game.asyncblit!.hwsurface!.doublebuf!.fullscreen!

  Game.run 400, 400 do |screen, background, objects, runner|

    Game.map('1.map', 32) do |top, left, object|
      case object
      when /w/
        objects << Wall.new(screen, top, left)
        objects << Wall.new(screen, top+16, left)
        objects << Wall.new(screen, top, left+16)
        objects << Wall.new(screen, top+16, left+16)

      when /b/
        objects << Beton.new(screen, top, left)
        objects << Beton.new(screen, top+16, left)
        objects << Beton.new(screen, top, left+16)
        objects << Beton.new(screen, top+16, left+16)

      when /t/
        tank = Tank.new( screen, background, left+30, top+30 )
        tank.hooks!
        objects << tank
        runner.make_magic_hooks_for( tank, { YesTrigger.new() => :handle } )

      when /\s/

      end
    end

    Sound['start.ogg'].play
  end

ensure
  Rubygame.quit()
end
