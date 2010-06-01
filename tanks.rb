require "config/environment"

begin

  Tanks.autoload_resources!("resources")

  Tanks.asyncblit!.hwsurface!.doublebuf!#.fullbackground!

  Tanks.run 400, 400 do |background, objects, runner|

    Tanks.map('1.map', 32) do |top, left, object|
      case object
      when /w/
        objects << Tanks::Wall.new(background, top, left)
        objects << Tanks::Wall.new(background, top+16, left)
        objects << Tanks::Wall.new(background, top, left+16)
        objects << Tanks::Wall.new(background, top+16, left+16)

      when /b/
        objects << Tanks::Beton.new(background, top, left)
        objects << Tanks::Beton.new(background, top+16, left)
        objects << Tanks::Beton.new(background, top, left+16)
        objects << Tanks::Beton.new(background, top+16, left+16)

      when /t/
        tank = Tanks::Tank.new( background, left+30, top+30 )
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
