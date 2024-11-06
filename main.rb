require_relative "lib/tree"

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

p tree.pretty_print

tree.insert(345)

p tree.pretty_print

tree.delete(8)

p tree.pretty_print

p tree.find(10)

# tree.level_order_iterative { |v| p v }
puts "Preorder: \n"
tree.preorder { |v| p v }
puts "Inorder: \n"
tree.inorder { |v| p v }
puts "Postorder: \n"
tree.postorder { |v| p v }
