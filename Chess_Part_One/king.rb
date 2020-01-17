require_relative "piece"
require_relative "stepable"
class King < Piece
    attr_reader :symbol

    def initialize(position, board, color)
        super
        @symbol = :king
    end

    def moves
        Stepable.moves(self)
    end
    
    def move_diffs
        "S"
    end

end