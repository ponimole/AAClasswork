require_relative "rook"
require_relative "bishop"
require_relative "queen"
require_relative "piece"
require "byebug"
class Board
    def initialize
        @grid = Array.new(8) {Array.new(8)}
        # @grid.each_with_index do |row,row_i|
        #     row.each_with_index do |space,col_i|
        #         position = [row_i,col_i]
        #         @grid[row_i][col_i] = Piece.new(position, self, :black) if row_i < 2
        #         @grid[row_i][col_i] = Piece.new(position, self, :white) if row_i >= @grid.length - 2
        #     end
        # end
        @grid[0][3] = Piece.new([0,3], self, :black)
        @grid[4][4] = Queen.new([4,4], self, :black)
    end

    def [](pos)
        y,x = pos
        @grid[y][x]
    end

    def move_piece(start_pos, end_pos)
        y_s, x_s = start_pos
        y_e, x_e = end_pos
        start_piece, end_piece = @grid[y_s][x_s], @grid[y_e][x_e]
        if start_piece == nil
            raise StandardError.new "there is no piece at this position"
        end
        if end_piece != nil && (end_piece.color == start_piece.color)
            raise StandardError.new "piece cannot be moved to this position"
        end
            @grid[y_e][x_e], @grid[y_s][x_s] = @grid[y_s][x_s], nil
            @grid[y_e][x_e].update_pos(end_pos)
    end
end