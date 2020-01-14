class Map
    def initialize
        @map = Array.new
    end

    def set(key, value)
        @map.each_with_index do |pair,i_1|
            pair.each_with_index do |k,i_2|
                if i_2 == 0
                    return @map[i_1][1] = value if k == key
                end
            end
        end
        @map << [key, value]
    end

    def get(key)
        @map.each_with_index do |pair,i_1|
            pair.each_with_index do |k,i_2|
                if i_2 == 0
                    return @map[i_1][1] if k == key
                end
            end
        end
    end

    def delete(key)
        @map.each_with_index do |pair,i_1|
            pair.each_with_index do |k,i_2|
                if i_2 == 0
                    return @map.delete_at(i_1) if k == key
                end
            end
        end
    end

    def show
        @map
    end
end