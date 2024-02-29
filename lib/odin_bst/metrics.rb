# frozen_string_literal: true

module OdinBST
  # Metrics for a binary search tree
  module Metrics
    def height(node)
      return -1 if node.nil?

      left_height = height(node.left)
      right_height = height(node.right)

      [left_height, right_height].max + 1
    end

    def depth(node)
      return -1 if temp.nil?

      depth = 0
      temp = @root

      until temp == node
        temp = node.value > temp.value ? temp.right : temp.left
        depth += 1
        return -1 if temp.nil?
      end

      depth
    end

    def balanced?
      left_height = height(@root.left)
      right_height = height(@root.right)

      left_height - right_height > -2 && left_height - right_height < 2
    end
  end
end
