class Sounds
  include Rubygame::NamedResource
  
  Sounds.autoload_dirs = [ File.join("resources","sound","wav"), File.join("resources","sound") ]
  
  def autoload( name )
    # Searches autoload_dirs for the file
    puts @autoload_dirs
    path = find_file( name )    
    if( path )
      return load_sound( path )
    else
      return nil
    end
  end
  
  def load_sound( path )
    puts "playing: " + path    
    return Rubygame::Sound.load(path)
  end
end