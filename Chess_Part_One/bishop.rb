require_relative "piece"
require_relative "slideable"
class Bishop < Piece
    def initialize(position, board, color)
        super
    end

    def moves
        Slideable.moves(self)
    end

    def move_dirs
        ["diagonal"]
    end
end