require_relative "merge_sort_al"
require_relative "binary_search_al"

arr = [0, 1, 5, 7]


puts '---- bad_two_sum? ---- O(n^2)'

def bad_two_sum?(arr, target_sum)
    pairs = []
    arr.each_with_index do |ele1,idx1|
        arr.each_with_index do |ele2,idx2|
            if idx2 > idx1
                return true if target_sum == ele1 + ele2
            end
        end
    end
    false
end

puts bad_two_sum?(arr, 6) # => should be true
puts bad_two_sum?(arr, 10) # => should be false

puts '---- okay_two_sum? ---- O(nlogn)'

def okay_two_sum?(arr, target_sum)
    sorted_arr = arr.merge_sort
    return false if sorted_arr[-1] < target_sum

    sorted_arr.each_with_index do |ele,idx|
        return true if bsearch(sorted_arr,(target_sum - ele)) != nil
    end
    false
end

puts okay_two_sum?(arr, 6) # => should be true
puts okay_two_sum?(arr, 10) # => should be false

puts '---- two_sum? ---- O(n)'

def two_sum?(arr, target_sum)
    hash = Hash.new

    arr.each do |ele|
        return true if hash[target_sum - ele]
    hash[ele] = true
  end
    false
end


puts two_sum?(arr, 6) # => should be true
puts two_sum?(arr, 10) # => should be false