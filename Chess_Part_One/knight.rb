require_relative "piece"
require_relative "stepable"
class Knight < Piece

    def initialize(position, board, color)
        super
        @symbol = :knight
    end

    def moves
        Stepable.moves(self)
    end

    def move_diffs
        "L"
    end

end