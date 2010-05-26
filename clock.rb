require "rubygems"
require "rubygame"

  $clock = Rubygame::Clock.new()

  # Set the desired framerate.
  $clock.target_framerate = 20

  # Make Clock#tick return ClockTicked (Rubygame 2.5+)
  $clock.enable_tick_events()

  # Allow Clock to work nicely with multiple ruby threads.
  # You can skip this if you don't use multiple threads.
  $clock.nice = true

  # Optimize clock for this computer.
  puts "Calibrating... "
  $clock.calibrate()
  puts "New granularity: %d ms"%[$clock.granularity]

  i = 0

  catch :quit do
    loop do

      tick_event = $clock.tick()  # call tick once per frame.

      # Give tick_event to an event handler or queue, or whatever.

      fps = $clock.framerate     # current framerate
      diff = tick_event.seconds  # time since previous call to tick

      puts "Tick %0.2d = %0.2d fps (%0.4f s since previous)"%[i, fps, diff]

      i += 1
      throw :quit if( i > 50 )

    end
  end