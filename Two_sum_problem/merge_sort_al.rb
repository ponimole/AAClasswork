class Array
    def merge_sort
        return [] if self.length == 0
        return self if self.length == 1

        middle_idx = self.length / 2

        left = self[0...middle_idx].merge_sort
        right = self[middle_idx..-1].merge_sort

        left.my_merge(right)
    end

    def my_merge (other_half)
        new_arr = []
        empty = false

        while !empty
            if self[0] < other_half[0]
                new_arr << self.shift
            else
                new_arr << other_half.shift
            end

            if self == []
                empty = true
                new_arr += other_half
            elsif other_half == []
                empty = true
                new_arr += self
            end
        end
        
        new_arr
    end

end

# p [].merge_sort # => []
# p [1].merge_sort # => [1]
# p [2,1].merge_sort # => [1, 2]
# p [3,2,1].merge_sort # => [1, 2, 3]
# p [7,3,18,4].merge_sort # => [3, 4, 7, 18]
# p [3,34,104,25,2,19,105,7,-1,2].merge_sort #=> [-1, 2, 2, 3, 7, 19, 25, 34, 104, 105]