require "byebug"
module Slideable

    # def Slideable.moves(board, position, move_dirs)
    def Slideable.moves(sliding_piece)
        y, x = sliding_piece.position
        available_moves = []
        m_d = sliding_piece.move_dirs
        available_moves += horizontal_moves(sliding_piece) if m_d.include?("horizontal")
        available_moves += vertical_moves(sliding_piece) if m_d.include?("vertical")
        available_moves += diag_down_moves(sliding_piece) + diag_up_moves(sliding_piece) if m_d.include?("diagonal")
        
        available_moves
    end

    def Slideable.diag_up_moves(sliding_piece)
        moves = []
        row, col = sliding_piece.position

        stop_idx = 7
        op_stop_idx = 0
        dir = 1
        2.times do
            until row == stop_idx || col == op_stop_idx
                pos = [row + dir,col - dir]
                piece = sliding_piece.board[pos]

                if piece == nil
                    moves << pos
                elsif piece.color == sliding_piece.color
                    break
                elsif piece.color != sliding_piece.color
                    moves << pos
                    break
                end
                row += dir
                col -= dir
            end
            row, col = sliding_piece.position
            stop_idx, op_stop_idx = op_stop_idx, stop_idx
            dir = -1
        end
        moves

    end

    def Slideable.diag_down_moves(sliding_piece)
        moves = []
        row, col = sliding_piece.position

        stop_idx = 0
        dir = -1
        
        2.times do
            until row == stop_idx || col == stop_idx
                pos = [row + dir,col + dir]
                piece = sliding_piece.board[pos]
                
                if piece == nil
                    moves << pos
                elsif piece.color == sliding_piece.color
                    break
                elsif piece.color != sliding_piece.color
                    moves << pos
                    break
                end
                row += dir
                col += dir
                
            end
            row, col = sliding_piece.position
            stop_idx = 7
            dir = 1
        end

        moves
    end

    def Slideable.axis_moves(sliding_piece, fixed_axis, move_axis, path)
        moves = []
        direction = -1
        stop_idx = 0
        m_a = move_axis

        2.times do
            until move_axis == stop_idx
                pos = [fixed_axis,(move_axis + direction)] if path == "h"
                pos = [(move_axis + direction),fixed_axis] if path == "v"

                piece = sliding_piece.board[pos]
                if piece == nil
                    moves << pos
                elsif piece.color == sliding_piece.color
                    break
                elsif piece.color != sliding_piece.color
                    moves << pos
                    break
                end
                move_axis += direction
            end
            direction = 1
            stop_idx = 7
            move_axis = m_a
        end
        moves
    end

    def Slideable.vertical_moves(sliding_piece)
        y,x = sliding_piece.position
        axis_moves(sliding_piece,x,y,"v")
    end

    def Slideable.horizontal_moves(sliding_piece)
        y,x = sliding_piece.position
        axis_moves(sliding_piece,y,x,"h")
    end
end