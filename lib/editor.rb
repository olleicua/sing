# Renders a curses based editor for a ActiveRecord record.

require 'dispel'
require 'terminfo'

class Editor
  attr_accessor :record
  def initialize record
    @record = record
    @postion = [10, 10]
  end
  
  def width
    TermInfo.screen_size[1]
  end
  
  def height
    TermInfo.screen_size[0]
  end
  
  def display
    Dispel::Screen.open do |screen|
      screen.draw draw

      Dispel::Keyboard.output do |key|
        case key
        when :up then move(0,-1)
        when :down then move(0,1)
        when :right then move(1,0)
        when :left then move(-1,0)
        when "q" then break
        end
        screen.draw draw
      end
    end
    # TODO: implement me
  end
  
  def move x, y
    @postion = [@postion[0] + y, @postion[1] + x]
  end
  
  def draw
    (('#' * width) + "\n" +
     (2 .. (height - 1)).map do |x|
       ('#' + (2 .. (width - 1)).map do |y|
          if @postion == [x, y] then '*' else ' ' end
        end.join('') + "#\n")
     end.join('') +
     ('#' * width) + "\n")
  end
end