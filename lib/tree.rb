require_relative "node"

class Tree
  def initialize(array)
    array.uniq!.sort!
    @root = build_tree(array)
  end

  def build_tree(array, first = 0, last = array.length - 1)
    return if first > last

    mid = (first + last) / 2
    Node.new(array[mid], build_tree(array, first, mid - 1), build_tree(array, mid + 1, last))
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
