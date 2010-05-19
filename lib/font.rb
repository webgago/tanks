
class Font < Rubygame::TTF
  
  include Rubygame::NamedResource
  
  class << self
    
    @resources = Hash.new
    @autoload_dirs = []
        
    def []( name, size )
      result = @resources[name][size] rescue nil
      
      if result.nil?
        result = autoload(name, size)
        if result
          self[name, size] = result
          result.name = name
        end
      end
      
      return result
    end
    
    def []=( name, size, value )
      if( value.kind_of? self )
        @resources[name] ||= {}
        @resources[name][size] = value
      else
        raise TypeError, "#{self}#[]= can only store instances of #{self}"
      end
    end
      
    # Searches each directory in Sound.autoload_dirs for a file with
    # the given filename. If it finds that file, loads it and returns
    # a Sound instance. If it doesn't find the file, returns nil.
    #
    # See Rubygame::NamedResource for more information about this
    # functionality.
    #
    def autoload( filename, size )
      path = find_file( filename )
      
      if( path )
        return load_font( path, size )
      else
        return nil
      end
    end
    
    
    # Load the given font file.    
    #
    # filename::   Full or relative path to the file. (String, required)
    # size::       point size (based on 72DPI). (That means the height in pixels from the bottom 
    #              of the descent to the top of the ascent.)
    #
    # Returns::    The new TTF instance. (Font)
    # May raise::  SDLError, if the sound file could not be loaded.
    #
    def load_font( filename, size )
      # TTF.setup must be called before any font object is created
      setup  
      # creates the font object, which is used for drawing text
      return new( filename, size )
    end
    
  end
end



