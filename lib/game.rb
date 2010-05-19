
module Game 
  
  class << self
    
    # Get the absolute path to the directory that this script is in.
    def dir
      this_dir = File.expand_path( File.join( File.dirname( File.expand_path(__FILE__) ), '..' ) )
    end
    
    # Set up autoload directories for Surface, Sound, Fonts and Music.
    # Surfaces (images) will be loaded from the "images" directory,
    # Sounds from "sound", and Music from "music".
    def autoload_resources!
      Surface.autoload_dirs << File.join(dir, "resources", "images")
      Sound.autoload_dirs   << File.join(dir, "resources", "sound")
      Music.autoload_dirs   << File.join(dir, "resources", "music")
      Font.autoload_dirs    << File.join(dir, "resources", "fonts")
    end
  end
  
end
