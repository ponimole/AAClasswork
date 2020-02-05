puts '---- first_anagram? ----'

def anagrams(word)
    anagrams = word.split("").permutation.to_a
    anagrams.map {|chars| chars.join("")}
end

def first_anagram?(word_1,word_2)
    anagrams(word_1).include?(word_2)
end

puts first_anagram?("gizmo", "sally")    #=> false
puts first_anagram?("elvis", "lives")    #=> true


puts '---- second_anagram? ----'

def find_index(s_char,word)
    word.each_char.with_index do |char,idx|
        return idx if s_char == char
    end
    nil
end

def second_anagram?(word_1,word_2)
    word_1.each_char do |char|
        return false if find_index(char,word_2) == nil
    end
    true
end

puts second_anagram?("gizmo", "sally")    #=> false
puts second_anagram?("elvis", "lives")    #=> true


puts '---- third_anagram? ----'

def third_anagram?(word_1,word_2)
    word_1.split("").sort == word_2.split("").sort
end

puts third_anagram?("gizmo", "sally")    #=> false
puts third_anagram?("elvis", "lives")    #=> true


puts '---- fourth_anagram? ----'

def hash_count(word)
    word_hash = Hash.new(0)
    word.each_char { |char| word_hash[char] += 1 }
    word_hash
end

def fourth_anagram?(word_1,word_2)
    hash_count(word_1) == hash_count(word_2)
end

puts third_anagram?("gizmo", "sally")    #=> false
puts third_anagram?("elvis", "lives")    #=> true