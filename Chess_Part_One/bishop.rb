require_relative "piece"
require_relative "slideable"
class Bishop < Piece
    attr_reader :symbol

    def initialize(position, board, color)
        super
    end

    def symbol
        :bishop
    end

    def moves
        Slideable.moves(self)
    end

    def move_dirs
        ["diagonal"]
    end
end