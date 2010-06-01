
module Tanks
  
  class << self

    @@options = []

    def asyncblit!
      @@options << Rubygame::ASYNCBLIT unless @@options.include?(Rubygame::ASYNCBLIT)
      self
    end

    def hwsurface!
      @@options << Rubygame::HWSURFACE unless @@options.include?(Rubygame::HWSURFACE)
      self
    end

    def doublebuf!
      @@options << Rubygame::DOUBLEBUF unless @@options.include?(Rubygame::DOUBLEBUF)
      self
    end

    def fullscreen!
      @@options << Rubygame::FULLSCREEN unless @@options.include?(Rubygame::FULLSCREEN)
      self
    end

    # Get the absolute path to the directory that this script is in.
    def dir
      File.expand_path( File.join( File.dirname( File.expand_path(__FILE__) ), '..' ) )
    end
    
    # Set up autoload directories for Surface, Sound, Fonts and Music.
    # Surfaces (images) will be loaded from the "images" directory,
    # Sounds from "sound", and Music from "music".
    def autoload_resources!(resources_dir)
      Surface.autoload_dirs << File.join(dir, resources_dir, "images")
      Sound.autoload_dirs   << File.join(dir, resources_dir, "sound")
      Music.autoload_dirs   << File.join(dir, resources_dir, "music")
      Font.autoload_dirs    << File.join(dir, resources_dir, "fonts")
    end
    
    def run( width, height, &block )
      @@runner = self::Runner.new( width, height, @@options)
      yield runner.background, runner.objects, runner
      @@runner.go
    end

    def runner
      @@runner
    end

    def map( name, step, &block )

      map = File.join(Tanks.dir, "resources", name)

      File.open(map) do |f|
        f.each_line do |line|
          x = 0
          line.each_char do |object|
            y = f.lineno

            left = x * step
            top = y * step

            yield top, left, object 

            x += 1
          end
        end
      end
    end
  end
  
end
