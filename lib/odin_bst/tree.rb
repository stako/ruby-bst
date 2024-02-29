# frozen_string_literal: true

module OdinBST
  # Binary Search Tree. Only accepts an array of numbers
  class Tree
    include Traversal
    include Metrics

    attr_accessor :root

    def initialize(array)
      array.uniq!
      array.sort!
      @root = build_tree(array)
    end

    # do not provide start, finish arguments
    def build_tree(array, start = 0, finish = array.size - 1)
      return nil if start > finish

      mid = (start + finish) / 2
      node = Node.new(array[mid])
      node.left = build_tree(array, start, mid - 1)
      node.right = build_tree(array, mid + 1, finish)
      node
    end

    def rebalance
      @root = build_tree(inorder)
    end

    def find(value)
      node = @root

      until node.value == value
        node = value > node.value ? node.right : node.left
        return nil if node.nil?
      end

      node
    end

    # do not provide node argument
    def insert(value, node = @root)
      return if node.value == value

      if value < node.value
        node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
      else
        node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
      end
    end

    # Tree.root = delete(value)
    def delete(value, root = @root) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      return if root.nil?

      if value < root.value
        root.left = delete(value, root.left)
      elsif value > root.value
        root.right = delete(value, root.right)
      else
        return root.right if root.left.nil?
        return root.left if root.right.nil?

        replacement = root.right
        replacement = replacement.left until replacement.left.nil?
        root.value = replacement.value
        root.right = delete(replacement.value, root.right)
      end
      root
    end

    def pretty_print(node = @root, prefix = "", is_left = true) # rubocop:disable Style/OptionalBooleanParameter
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
  end
end
