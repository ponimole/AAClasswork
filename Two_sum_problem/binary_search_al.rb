 def bsearch(array, target)
    return nil if array == []
    
    middle_idx = array.length / 2
    middle_ele = array[middle_idx]

    if target == middle_ele
        return middle_idx
    end
    if array.length == 1
        return nil
    end

    sub_array = []
    if target < middle_ele
        sub_array = array[0...middle_idx]
        bsearch(sub_array, target) - sub_array.length + middle_idx if bsearch(sub_array, target) != nil
    else
        sub_array = array[(middle_idx + 1)..-1]
        bsearch(sub_array, target) + sub_array.length + (middle_idx - 1) if bsearch(sub_array, target) != nil
    end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil