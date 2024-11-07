require_relative "lib/tree"

tree = Tree.new((Array.new(15) { rand(1..100) }))

p tree.pretty_print

# tree.level_order_iterative { |v| p v }
puts "Preorder: \n"
tree.preorder { |v| p v }
puts "Inorder: \n"
tree.inorder { |v| p v }
puts "Postorder: \n"
tree.postorder { |v| p v }
