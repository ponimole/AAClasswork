def my_uniq(array)
    new_arr = []
    array.each { |ele| new_arr << ele if !new_arr.include?(ele) }
    new_arr
end

class Array
    def two_sum
        ig_idxs = []
        new_arr = []
        self.each_with_index do |ele1,idx1|
            self.each_with_index do |ele2,idx2|
                if idx2 > idx1 && !ig_idxs.include?(idx2)
                    if ele1 + ele2 == 0
                        new_arr << [idx1,idx2]
                        ig_idxs << idx2
                    end
                end
            end
        end
        new_arr
    end
end

def my_transpose(matrix)
    n = matrix.length
    new_matrix = Array.new(n) {Array.new(n)}

    matrix.each_with_index do |row,row_i|
        row.each_with_index {|ele,col_i| new_matrix[col_i][row_i] = ele}
    end
    new_matrix
end

def stock_picker(array)
    pot_picks = {}
    array.each_with_index do |price1,idx1|
        array.each_with_index do |price2,idx2|
            pot_picks[price2 - price1] = [idx1,idx2] if idx2 > idx1
        end
    end
    profits = pot_picks.map { |k,v| k }
    best_pick = profits.inject {|max,profit| profit > max ? profit : max}
    pot_picks[best_pick]
end

class TowersOfHanoi
    attr_reader :piles, :total_disc_count
    def initialize(p0 = 5, p1 = 0, p2 = 0)
        @total_disc_count = p0 + p1 + p2
        @piles = []
        @piles << Pile.new(p0)
        @piles << Pile.new(p1)
        @piles << Pile.new(p2)
    end

    def game_loop
        move
        while won? == false
            move
        end
    end

    def won?
        @total_disc_count == @piles[2].count
    end

    def move
        puts
        print "Remove disc from pile - "
        remove_from_pile = gets.chomp.to_i

        print "Add disc to pile - "
        add_to_pile = gets.chomp.to_i
        
        if @piles[remove_from_pile].count > 0
            @piles[remove_from_pile].remove_disc
            @piles[add_to_pile].add_disc
        else
            puts "invalid move"
        end
    end


end

class Pile
    attr_reader :count
    def initialize(count = 0)
        @count = count
    end

    def add_disc
        @count += 1
    end

    def remove_disc
        @count -= 1
    end

end