# frozen_string_literal: true

require_relative "lib/odin_bst"

array = Array.new(15) { rand(1..100) }
# array = [33, 44, 60, 61, 62, 74, 75, 100]
tree = OdinBST::Tree.new(array)

puts "Created a binary search tree:"
tree.pretty_print

puts "Tree is #{tree.balanced? ? '' : 'un'}balanced \n\n"

puts "Level-order traversal: #{tree.level_order_recursive}"
puts "Inorder traversal: #{tree.inorder_recursive}"
puts "Preorder traversal: #{tree.preorder_recursive}"
puts "Postorder traversal: #{tree.postorder_recursive} \n\n"

puts "Adding several new values:"
3.times { tree.insert(rand(101..200)) }
tree.pretty_print

puts "Tree is #{tree.balanced? ? '' : 'un'}balanced \n\n"

puts "Rebalancing tree:"
tree.rebalance
tree.pretty_print
puts "Tree is #{tree.balanced? ? '' : 'un'}balanced \n\n"

puts "Level-order traversal: #{tree.level_order_recursive}"
puts "Inorder traversal: #{tree.inorder_recursive}"
puts "Preorder traversal: #{tree.preorder_recursive}"
puts "Postorder traversal: #{tree.postorder_recursive}"
