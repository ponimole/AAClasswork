require_relative "00_tree_node.rb"
require "byebug"
require "colorize"
class MazeReader
    def self::from_file(maze)
        grid = Array.new
        File.foreach(maze) do |line|
            array = []
            
            line.each_char do |val|
                array << val
            end
            grid << array
        end
        grid
    end
end

class MazeSolver
    def initialize(maze)
        if maze.is_a?(Array)
            @grid = maze
        else
            @grid = MazeReader.from_file(maze)
        end
        @root_node = get_start_node
        @considered_positions = []
    end

    def solve
        print_maze
        prompt
        build_move_tree
        path = find_path("E")
        print_path(path)
    end

    def prompt
        puts "press enter to solve"
        gets
    end

    def print_path(path)
        system "clear"
        return "no path found" if path == []
        @grid.each_with_index do |row,row_i|
            print_row = ""
            row.each_with_index do |val,col_i|
                if path.include?([row_i,col_i])
                    print_row += "X".colorize(:yellow)
                else
                    print_row += val 
                end
            end
            puts print_row
        end
    end

    def get_start_node
        @grid.each_with_index do |row, row_i|
            row.each_with_index do |value, col_i|
                return PolyTreeNode.new("S", [row_i, col_i]) if value == "S"
            end
        end
    end

    def build_move_tree
        queue = [@root_node]
        @considered_positions << @root_node.position
        until queue.length == 0
            parent_node = queue.shift
            print(parent_node)
            new_move_postions(parent_node).each do |child_pos|
                y,x = child_pos
                val = @grid[y][x]
                child_node = PolyTreeNode.new(val, child_pos)
                queue << child_node
                @considered_positions << child_node.position
                parent_node.add_child(child_node)
            end
        end
    end

    def print_maze
        system "clear"
        @grid.each_with_index do |row,row_i|
            print_row = ""
            row.each_with_index do |val,col_i|
                if val == "S" 
                    print_row += val.colorize(:green)
                elsif val == "E" 
                    print_row += val.colorize(:red)
                else
                    print_row += val
                end
            end
            puts print_row
        end
    end

    def print(node)
        system "clear"
        @grid.each_with_index do |row,row_i|
            print_row = ""
            row.each_with_index do |val,col_i|
                if node.position == [row_i,col_i]
                    print_row += "C"
                else
                    print_row += val 
                end
            end
            puts print_row
        end
    end

    def find_path(value)
        
        end_node = @root_node.dfs(value)
        
        trace_path_back(end_node)
    end

    def new_move_postions(node)
        pos = node.position
        new_moves = sur_pos(node.position).select {|pos| valid?(pos)}
        
        new_moves
    end

    def valid?(pos)
        y,x = pos
        if within_grid?(pos)
            value = @grid[y][x] 
            return (value == " " || value == "E") && !@considered_positions.include?(pos)
        end
        false
    end

    def within_grid?(pos)
        y,x = pos
        x > -1 && x < @grid[0].length && y > -1 && y < @grid.length
    end

    def trace_path_back(end_node)
        path = []
        until end_node == @root_node
            path.unshift(end_node.position)
            end_node = end_node.parent
        end
        path.unshift(@root_node.position)
        path
    end

    def sur_pos(pos)
        y,x = pos
        [ 
            [ y + 1,x ],
            [ y,x - 1 ],
            [ y,x + 1 ],
            [ y - 1,x ] 
        ]
    end
end

class MazeGenerator
    attr_reader :grid
    def initialize(size)
        @grid = Array.new(size) {Array.new(size * 2)}
        generate
        place_start_and_end
    end

    def generate
        @grid.each_with_index do |row,row_i|
            row.each_with_index do |space,col_i|
                if row_i == 0 || row_i == @grid.length - 1
                    @grid[row_i][col_i] = "*"
                elsif col_i == 0 || col_i == row.length - 1
                    @grid[row_i][col_i] = "*"
                else
                    rand(0...4) == 0 ? @grid[row_i][col_i] = "*" : @grid[row_i][col_i] = " "
                end
            end
        end
    end

    def place_start_and_end
        height = @grid.length - 2
        width = @grid[0].length - 2

        y = rand(1..height)
        x = rand(1..width)
        @grid[y][x] = "S"

        y = rand(1..height)
        x = rand(1..width)
        @grid[y][x] = "E"
    end
end

def start_maze
    valid_selection = false
    until valid_selection
        puts "would you like to solve the default maze or a random maze (D or R)"
        selection = gets.chomp
        if selection.upcase == "R"
            maze = MazeGenerator.new(30)
            maze = maze.grid
            valid_selection = true
        elsif selection.upcase == "D"
            maze = "maze1.txt"
            valid_selection = true
        end
    end
    MazeSolver.new(maze).solve
end


start_maze