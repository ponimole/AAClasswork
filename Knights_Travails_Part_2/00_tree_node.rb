class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        if @parent != nil
            @parent.children.delete(self) if @parent.children.include?(self)
        end
        @parent = parent_node
        if parent_node != nil
            parent_node.children << self if !parent_node.children.include?(self)
        end
    end
    
    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "not a child" if !child_node.parent.children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if @value == target_value
        @children.each do |child_node|
            node = child_node.dfs(target_value)
            return node if node != nil
        end
        nil
    end

        def bfs(target_value)
        queue = []
        queue << self

        until queue.length == 0
            node = queue.shift
            return node if node.value == target_value
            node.children.each {|child_node| queue << child_node}
        end
    end
end