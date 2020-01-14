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
