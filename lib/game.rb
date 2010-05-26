
module Game 
  
  class << self


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
    
    def run( &block )
      @@runner = self::Runner.new
      yield @@runner
      @@runner.go
    end

    def runner
      @@runner
    end
    
  end
  
end
