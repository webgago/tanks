require 'rubygems'
require 'rubygame'
require "hud"

Rubygame.init

include Rubygame
include Rubygame::Events
include Rubygame::EventActions
include Rubygame::EventTriggers

class Tanks
  include EventHandler::HasEventHandler
  
  def initialize
    @screen = Rubygame::Screen.new [1280,800], 0, [Rubygame::FULLSCREEN, Rubygame::ASYNCBLIT, Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @screen.title = "Generic Game!"

    @text = ''
    
    @queue = EventQueue.new
    @queue.enable_new_style_events
    @queue.ignore = [MouseMoved]
    
    @clock = Clock.new
    @clock.target_framerate = 30
    make_magic_hooks( :q => :do_exit,
                      :escape       => :do_exit,
                      :mouse_right  => :do_exit,
                      QuitRequested => :do_exit,
                      KeyPressed => :key_pressed )
  end
  
  def make_queue
    # Create EventQueue with new-style events (added in Rubygame 2.4)
    @queue = EventQueue.new()
    @queue.enable_new_style_events
 
    # Don't care about mouse movement, so let's ignore it.
    @queue.ignore = [MouseMoved]
  end
 
  # Create the Rubygame window.
  def make_screen
    @screen = Screen.open( [640, 480] )
    @screen.title = "Square! In! Space!"
  end
  
  def key_pressed(event)
    return if [:alt, :left_alt, :right_alt,
        :ctrl, :left_ctrl, :right_ctrl,
        :shift, :left_shift, :right_shift,
        :meta, :left_meta, :right_meta,
        :numlock, :capslock, :mode].include? event.key
        
    if [:shift, :left_shift, :right_shift].include? event.key
      @text += event.key.to_s.upcase
    else
      @text += event.key.to_s
    end
  end
  
  def do_exit
    puts "exit"
    Rubygame.quit
    exit
  end
  
  def run
    loop do
      update
      draw
      @clock.tick
    end
  end

  def update    
    @queue.each do |ev|
      handle(ev)
      case ev
      when QuitEvent
        quit
      end
    end
  end

  def draw
    # to create the hud
    @hud = Hud.new :screen => @screen

    # to update contents
    @hud.update :time => Time.now.strftime("%H:%M:%S")

    # to draw
    @screen.fill :black
    @hud.draw
    draw_text
    @screen.flip
    @screen.update
    
  end
  
  def draw_text
    return if @text.length < 1
    # to create the hud
    @hud = Hud.new :screen => @screen

    # to update contents
    @hud.update :text => @text

    # to draw
    @screen.fill :black
    @hud.draw [100,100]
  end
end

game = Tanks.new
game.run



