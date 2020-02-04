puts '---- O(n^2) ----'

def my_min(list)
    list.each_with_index do |ele1,idx1|
        if idx1 < list.length - 1
            if list[idx1 + 1..-1].all? { |ele2| ele1 < ele2 }
                return ele1
            end
        end
    end
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
puts my_min(list)  # =>  -5

puts '---- O(n) ----'

def my_min(list)
    list.inject {|ele1,ele2| ele1 < ele2 ? ele1 : ele2 }
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
puts my_min(list)  # =>  -5

def sub_arrs(list)
    sub_arrs = []
    list.each_with_index do |ele1,idx1|
        sub_arrs << [ele1]
        list.each_with_index do |ele2,idx2|
            if idx2 > idx1
                sub_arrs << list[idx1..idx2]
            end
        end
    end
    sub_arrs
end

# print sub_arrs(list)

def largest_contiguous_subsum(list)
    subs = sub_arrs(list)
    sums = subs.map do |arr|
        arr.inject do |ele1,ele2|
            ele1 + ele2
        end
    end
    sums.inject {|ele1,ele2| ele1 < ele2 ? ele2 : ele1}
end

# print largest_contiguous_subsum(list)

# #Example 1
list = [5, 3, -7]
puts largest_contiguous_subsum(list) # => 8

# #Example 2
list = [2, 3, -6, 7, -6, 7]
puts largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

# #Example 3
list = [-5, -1, -3]
puts largest_contiguous_subsum(list) # => -1 (from [-1])