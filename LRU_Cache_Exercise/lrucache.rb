class LRUCache
    def initialize(size)
        @size = size
        @cache = Array.new
    end

    def count
        @cache.length
    end

    def add(el)
        if @cache.any? { |ele| el == ele }
            @cache.delete(el)
        elsif count == @size
            @cache.shift
        end

        @cache << el
    end

    def show
        print @cache
    end

    private
end