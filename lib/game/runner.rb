module Game


  class Runner
    include Rubygame::Events
    include Rubygame::EventActions
    include Rubygame::EventTriggers
    include EventHandler::HasEventHandler
    
    attr_accessor :objects
    attr_accessor :screen
    attr_accessor :background
    attr_accessor :clock
    
    def initialize(width, height, options)
      Rubygame.init
      @objects = []

      make_screen(width, height, options)
      make_clock
      make_queue
      make_event_hooks      
    end

    # The "main loop". Repeat the #step method
    # over and over and over until the user quits.
    def go
      catch(:quit) do
        loop { step }
      end
    end

    private

    # Create a new Clock to manage the game framerate
    # so it doesn't use 100% of the CPU
    def make_clock
      @clock = Clock.new()
      @clock.target_framerate = 40      
      @clock.enable_tick_events
      @clock.calibrate
    end

    # Set up the event hooks to perform actions in
    # response to certain events.
    def make_event_hooks
      hooks = {
        :escape => :quit,
        :q => :quit,
        QuitRequested => :quit
      }
      make_magic_hooks( hooks )
    end

    # Create an EventQueue to take events from the keyboard, etc.
    # The events are taken from the queue and passed to objects
    # as part of the main loop.
    def make_queue
      # Create EventQueue with new-style events (added in Rubygame 2.4)
      @queue = EventQueue.new()
      @queue.enable_new_style_events

      # Don't care about mouse movement, so let's ignore it.
      @queue.ignore = [MouseMoved]
    end

    # Create the Rubygame window.
    def make_screen(width, height, options)
      @screen = Screen.open( [width, height], 0, options )
      @screen.title = "The Tanks!"

      # Create The Background
      @background = Surface.new(@screen.size)
      @background.fill([0,0,0])
      @background.blit(@screen, [0,0])
      @screen.update
    end

    # Quit the game
    def quit
      throw :quit
    end

    # Do everything needed for one frame.
    def step

      @background.fill([0,0,0])

      # Fetch input events, etc. from SDL, and add them to the queue.
      @queue.fetch_sdl_events

      # Tick the clock and add the TickEvent to the queue.
      @queue << @clock.tick

      # Process all the events on the queue.
      @queue.each do |event|
        handle( event )
      end

      @background.blit(@screen, [0, 0])

      # Draw the ship in its new position.
      @objects.each do |object|
        object.update
        object.draw( @screen )
        @objects.delete(object) if object.delete? rescue ''
      end 

      # Refresh the screen.
      @screen.update
      @screen.flip
    end
  end
end