class Piece
    attr_reader :position, :board, :color, :symbol

    def initialize(position, board, color)
        @position = position
        @board = board
        @color = color
    end

    def to_s
    end

    def empty?
    end

    def valid_moves
    end

    def pos=(val)
    end

    def symbol
    end

    # def moves
    # end

    def update_pos(position)
        @position = position
    end

    private
    def move_into_check?(end_pos)
    end
end