require "./00_tree_node.rb"
require "byebug"
class KnightPathFinder

    def initialize(start_pos = [0,0])
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree
    end

    def build_move_tree
        queue = [@root_node]
        until queue.length == 0
            parent_node = queue.shift
            new_move_postions(parent_node.value).each do |child_move|
                child_node = PolyTreeNode.new(child_move)
                queue << child_node
                parent_node.add_child(child_node)
            end
        end
    end

    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        path = []
        until end_node == @root_node
            path.unshift(end_node.value)
            end_node = end_node.parent
        end
        path.unshift(@root_node.value)
        path
    end

    def new_move_postions(pos)
        new_positions = KnightPathFinder.valid_moves(pos).select do |move|
            !@considered_positions.include?(move)
        end
        @considered_positions += new_positions
        new_positions
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