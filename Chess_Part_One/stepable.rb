module Stepable

    def Stepable.moves(king)
        moves = []
        s_p = surrounding_positions(king) if king.move_diffs.include?("S")
        s_p = l_positions(king) if king.move_diffs.include?("L")

        s_p.each do |pos|
            if king.board[pos] == nil
                moves << pos 
            elsif king.board[pos].color != king.color
                moves << pos 
            end
        end
        moves
    end

    def Stepable.l_positions(king)
        l_positions = []
        x,y = king.position
        transitions = [  
                    [-2,-1],[-2,1],
                    [-2,-1],[-1,2],
                    [1,-2],[1,2],
                    [2,-1],[2,1]
                ]
                
        transitions.each do |transition|
            tran_x, tran_y = transition
            new_x, new_y = (x + tran_x), (y + tran_y)
            
            if new_x > -1 && new_y > -1 && new_x < 8 && new_y < 8
                l_positions << [new_x, new_y] 
            end
        end

        l_positions
    end

    def Stepable.surrounding_positions(king)
        surrounding_positions = []
        x,y = king.position
        transitions = [  
                    [-1,-1],[-1,0],[-1,1],
                    [0,-1],         [0,1],
                    [1,-1], [1,0],  [1,1]
                ]
                
        transitions.each do |transition|
            tran_x, tran_y = transition
            new_x, new_y = (x + tran_x), (y + tran_y)
            
            if new_x > -1 && new_y > -1 && new_x < 8 && new_y < 8
                surrounding_positions << [new_x, new_y] 
            end
        end

        surrounding_positions
    end
end