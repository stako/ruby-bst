# frozen_string_literal: true

module OdinBST
  # Traversal methods for a binary search tree. Iterative and recursive
  module Traversal
    def level_order
      queue = [@root]
      values = []

      until queue.empty?
        node = queue.shift
        block_given? ? yield(node) : values << node.value
        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?
      end

      values unless block_given?
    end

    def inorder # rubocop:disable Metrics/MethodLength
      stack = []
      values = []
      node = @root

      until node.nil? && stack.empty?
        until node.nil?
          stack << node
          node = node.left
        end

        node = stack.pop
        block_given? ? yield(node) : values << node.value
        node = node.right
      end

      values unless block_given?
    end

    def preorder
      stack = [@root]
      values = []

      until stack.empty?
        node = stack.pop
        block_given? ? yield(node) : values << node.value
        stack << node.right unless node.right.nil?
        stack << node.left unless node.left.nil?
      end

      values unless block_given?
    end

    def postorder # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      stack = []
      values = []
      node = @root

      loop do
        until node.nil?
          stack << node
          stack << node
          node = node.left
        end

        break if stack.empty?

        node = stack.pop

        if !stack.empty? && stack[-1] == node
          node = node.right
        else
          block_given? ? yield(node) : values << node.value
          node = nil
        end
      end

      values unless block_given?
    end

    # do not provide queue, values arguments
    def level_order_recursive(queue = [@root], values = [], &block)
      if queue.empty?
        return block_given? ? nil : values
      end

      node = queue.shift
      block&.call(node)
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
      values << node.value
      level_order_recursive(queue, values, &block)
    end

    # do not provide node, values arguments
    def inorder_recursive(node = @root, values = [], &block)
      if node.nil?
        return block_given? ? nil : values
      end

      inorder_recursive(node.left, values, &block)
      block&.call(node)
      values << node.value
      inorder_recursive(node.right, values, &block)
      values
    end

    # do not provide node, values arguments
    def preorder_recursive(node = @root, values = [], &block)
      if node.nil?
        return block_given? ? nil : values
      end

      values << node.value
      block&.call(node)
      preorder_recursive(node.left, values, &block)
      preorder_recursive(node.right, values, &block)
      values
    end

    # do not provide node, values arguments
    def postorder_recursive(node = @root, values = [], &block)
      if node.nil?
        return block_given? ? nil : values
      end

      postorder_recursive(node.left, values, &block)
      postorder_recursive(node.right, values, &block)
      values << node.value
      block&.call(node)
      values
    end
  end
end
