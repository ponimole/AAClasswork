require "byebug"
require_relative "flashColor"
require_relative "keypress"
class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
    @flash_color = {}
    @no_color = FlashColor.new
    build_flash_color
  end

  def build_flash_color
    COLORS.each do |color| 
      @flash_color[color] = FlashColor.new(color.to_sym)
    end
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    if !@game_over
      show_sequence
      if require_sequence
        round_success_message 
        @sequence_length += 1
      end
    end
  end

  def show_sequence
    @no_color.print
    sleep(2)
    add_random_color
    @seq.each do |color|
      @flash_color[color].print
      sleep(0.75)
      @no_color.print
      sleep(0.75)
    end
  end

  def require_sequence
    @seq.each do |color|
      @game_over = true if color != get_color
    end
    true
  end

  def get_color
    position = get_pos
    if position == [0,0]
      "red"
    elsif position == [0,1]
      "blue"
    elsif position == [1,0]
      "green"
    elsif position == [1,1]
      "yellow"
    end
  end

  def get_pos
    row = 0
    col = 0
    position = [row,col]
    pos_selected = false
    until pos_selected
      case update_pos
      when "ENTER"
        pos_selected = true
      when "UP"
        row = 0 if row == 1
      when "DOWN"
        row = 1 if row == 0
      when "LEFT"
        col = 0 if col == 1
      when "RIGHT"
        col = 1 if col == 0
      end
      position = [row,col]
      print(position)
    end
    [row,col]
  end

  def print(position)
    if position == [0,0]
      @flash_color["red"].print
    elsif position == [0,1]
      @flash_color["blue"].print
    elsif position == [1,0]
      @flash_color["green"].print
    elsif position == [1,1]
      @flash_color["yellow"].print
    end
  end

  def add_random_color
    @seq << COLORS[rand(3)]
  end

  def round_success_message
    puts "Round " + @sequence_length.to_s + " Won"
    sleep(2)
  end

  def game_over_message
    puts "You Lose"
    sleep(2)
    puts "Resetting Game"
    sleep(2)
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

s = Simon.new

s.play