class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack.unshift(el)
    end

    def pop
        @stack.shift
    end

    def peek
        @stack[0]
    end
end