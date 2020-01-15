require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    
    @prev_move_pos = prev_move_pos
  end



  def losing_node?(evaluator)
    winner = @board.winner
    
    return winner == alternate_mark(evaluator) if @board.over?

    return true if children.all? do |child|
      child.losing_node?(evaluator)
    end

    return true if children.any? do |child|
      child.losing_node?(evaluator)
    end
    false
  end

  def winning_node?(evaluator)
    winner = @board.winner
    
    return winner == evaluator if @board.over?
    
    return true if children.all? do |child|
      child.winning_node?(evaluator)
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    game_states = []
    
    @board.rows.each_with_index do |row,row_i|
      row.each_with_index do |pos,col_i|
        if pos.nil?
          new_board = @board.dup
          new_board.rows[row_i][col_i] = @next_mover_mark
          prev_move_pos = [row_i,col_i]
          child = TicTacToeNode.new(new_board, alternate_mark(@next_mover_mark), prev_move_pos)
          game_states << child
        end
      end
    end
    game_states
  end

  def alternate_mark(mark)
    if mark == :x
      :o 
    elsif mark == :o
      :x
    end
  end
end
