require "byebug"
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) {Array.new}
    @side1 = name1
    @side2 = name2
    @current_player_name = nil
    @cur_side_idx = nil
    place_stones
  end

  def store_cups_idxs
    [13,6]
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    s_cups_idxs = store_cups_idxs
    @cups.each_with_index do |cup,idx| 
      4.times {@cups[idx] << :stone} if !s_cups_idxs.include?(idx)
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !(start_pos >= 0 && start_pos < @cups.length)
    raise "Starting cup is empty" if @cups[start_pos].length == 0
  end

  def make_move(start_pos, current_player_name)
    @current_player_name = current_player_name
    @cur_side_idx = side_idx(current_player_name)
    stones = []
    stones << @cups[start_pos].pop until @cups[start_pos].empty?
    cups_length = @cups.length
    next_pos = nil
    until stones.empty?
      start_pos += 1
      next_pos = (start_pos) % cups_length
      if !store_cups_idxs.include?(next_pos) || next_pos == @cur_side_idx
        @cups[next_pos] << stones.pop 
      end
    end
    render
    next_turn(next_pos)
  end

  def side_idx(current_player_name)
    return @cups.length - 1 if current_player_name == @side2
    (@cups.length - 1) / 2
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns 
    # :switch, :prompt, or ending_cup_idx
    ending_cup_length = @cups[ending_cup_idx].length
    return :prompt if ending_cup_idx == @cur_side_idx
    return ending_cup_idx if ending_cup_length > 1
    return :switch if ending_cup_length == 1
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    top = (7..12).to_a
    bottom = (0..5).to_a
    
    @cups.each_with_index do |cup,idx|
      if bottom.include?(idx)
        bottom.delete(idx) if cup.empty?
      elsif top.include?(idx)
        top.delete(idx) if cup.empty?
      end
    end
    
    bottom.empty? || top.empty?
  end

  def winner
    side2_idx, side1_idx = store_cups_idxs
    side2_score = @cups[side2_idx].length
    side1_score = @cups[side1_idx].length
    return :draw if side2_score == side1_score
    return @side1 if side1_score > side2_score
    @side2
  end
end
