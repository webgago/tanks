module Tanks
  
  class Wall < GObject
    include Destroyable
    include Obstruction

    HP = 200

    def initialize( parent, top, left )
      super(parent, :left => left, :top => top)
      @hp = 200
    end

    def update
    
    end

    def hit
      @hp = @hp - (HP * 1) rescue @hp = HP - (HP * 1)
    end

    def delete?
      @hp == 0 or @hp < 0
    end

  
  end
end
