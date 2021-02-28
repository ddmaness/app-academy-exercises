class PolyTreeNode
    def initialize(value)
        @value = value
        @parent = nil
        @children = Array.new()
    end

    def parent
        return @parent
    end

    def children
        return @children
    end

    def value
        return @value
    end

    def parent=(node)
        unless @parent == nil
            @parent.children.filter! {|child| child != self}
        end
        @parent = node
        unless @parent == nil || @parent.children.include?(self)
            @parent.children << self
        end
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        if child_node.parent == nil
            raise 'This node is not a child'
        else
            child_node.parent = nil
        end
    end

    def dfs(target_value)
        if @value == target_value
            return self
        end
        children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = Array.new()
        queue << self
        until queue.length == 0
            current_node = queue.shift()
            if current_node.value == target_value
                return current_node
            else
                current_node.children.each {|child| queue << child}
            end
        end
    end
end