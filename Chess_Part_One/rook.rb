require_relative "piece"
require_relative "slideable"
class Rook < Piece
    attr_reader :symbol
    
    def initialize(position, board, color)
        super
    end

    def moves
        Slideable.moves(self)
    end

    def move_dirs
        ["horizontal", "vertical"]
    end
end