school_of_fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

p '---- Sluggish Octopus ----  O(n^2) ----'

def sluggish_octopus(school)
    max = 0
    school.each_with_index do |fish1,idx1|
        school.each_with_index do |fish2,idx2|
            if idx2 > idx1
                if fish1.length < fish2.length
                    max = fish2
                end
            end
        end
    end
    max
end

puts sluggish_octopus(school_of_fish) #=> "fiiiissshhhhhh"

p '---- Dominant Octopus ---- O(n log n) ----'

class Sorting

  def self.merge_sort (array, &prc)
    return array if array.length <= 1

    mid_idx = array.length / 2
    merge(
      merge_sort(array.take(mid_idx), &prc),
      merge_sort(array.drop(mid_idx), &prc),
      &prc
    )
  end

  def self.merge(left, right, &prc)
    merged_array = []
    prc = Proc.new { |num1, num2| num1.length <=> num2.length } unless block_given?
    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged_array << left.shift
      when 0
        merged_array << left.shift
      when 1
        merged_array << right.shift
      end
    end

    merged_array + left + right
  end
end


def dominant_octopus(school)
    Sorting.merge_sort(school)
end

puts dominant_octopus(school_of_fish)[-1] #=> "fiiiissshhhhhh"

p '---- Clever Octopus ---- O(n) time ----'

def clever_octopus(school)
    school.inject {|longest_fish,fish| longest_fish.length < fish.length ? fish : longest_fish}
end

puts clever_octopus(school_of_fish) #=> "fiiiissshhhhhh"

p '---- Dancing Octopus ---- O(n) time ----'

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(move, tiles_array)
    tiles_array.each_with_index {|tile,idx| return idx if tile == move}
end

puts slow_dance("up", tiles_array) #=> 0

puts slow_dance("right-down", tiles_array) #=> 3

p '---- Constant Dance! ---- O(1) time ----'

tiles_hash = {}
tiles_array.each_with_index {|tile,idx| tiles_hash[tile] = idx}

def fast_dance(move, tiles_hash)
    tiles_hash[move]
end

puts fast_dance("up", tiles_hash) #=> 0

puts fast_dance("right-down", tiles_hash) #=> 3

