require_relative "piece"
require_relative "slideable"
class Queen < Piece
    attr_reader :symbol

    def initialize(position, board, color)
        super
    end

    def symbol
        :queen
    end

    def moves
        Slideable.moves(self)
    end

    def move_dirs
        ["diagonal", "horizontal", "vertical"]
    end
end