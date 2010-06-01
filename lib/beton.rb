module Tanks

  class Beton < Wall

    HP = Infinity

    def initialize( screen, top, left)
      super( screen, top, left )
      @hp = Infinity
    end


  end
  
end
