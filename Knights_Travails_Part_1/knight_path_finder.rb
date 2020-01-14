require "./00_tree_node.rb"
require "byebug"
class KnightPathFinder

    def initialize(start_pos = [0,0])
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree
    end

    def build_move_tree

    end

    def find_path(end_pos)

    end

    def self::valid_moves(pos)
        valid_moves = []
        x,y = pos
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
                valid_moves << [new_x, new_y] 
            end
        end

        valid_moves
    end
end