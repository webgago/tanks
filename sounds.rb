module Game
  class Sound
    include Rubygame::NamedResource
  
    Sound.autoload_dirs = [ 
      File.join(File.dirname(__FILE__), "resources", "sound", "wav"), 
      File.join(File.dirname(__FILE__), "resources", "sound") 
    ]
    
    @@resources = {}

    def self.[]=(name,value)
      @@resources[name] = value
    end

    def self.[](name)       
      result = @@resources[name]
    
      if result.nil?
        result = autoload(name)
        if result
          self[name] = result
          result.name = name
        end
      end
    
      return result        
    end
  
    def self.autoload( name )    
      # Searches autoload_dirs for the file    
      path = find_file( name )    
      if( path )
        return load_sound( path )
      else
        return nil      
      end
    end
  
    def self.load_sound( path )
      return Rubygame::Sound.load(path)
    end
  end
end