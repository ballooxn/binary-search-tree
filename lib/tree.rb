require_relative "node"

class Tree
  def initialize(array)
    array.uniq! unless array.length == 1
    array.sort!
    @root = build_tree(array)
  end

  def build_tree(array, first = 0, last = array.length - 1)
    return if first > last || array.nil?

    mid = (first + last) / 2
    Node.new(array[mid], build_tree(array, first, mid - 1), build_tree(array, mid + 1, last))
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, current_node = @root)
    return Node.new(value) if current_node.nil? || current_node.data == value

    if value > current_node.data
      current_node.right = insert(value, current_node.right)
    else
      current_node.left = insert(value, current_node.left)
    end

    current_node
  end

  def get_successor(curr)
    curr = curr.right
    curr = curr.left while !curr.nil? && !curr.left.nil?
    curr
  end

  def delete(value, curr = @root)
    return curr if curr.nil?

    if curr.data > value
      curr.left = delete(value, curr.left)
    elsif curr.data < value
      curr.right = delete(value, curr.right)
    else
      if curr.left.nil?
        return curr.right
      elsif curr.right.nil?
        return curr.left
      end

      succ = get_successor(curr)
      curr.data = succ.data
      curr.right = delete(succ.data, curr.right)
    end

    curr
  end

  def find(value, curr = @root)
    return nil if curr.nil?

    if value < curr.data
      find(value, curr.left)
    elsif value > curr.data
      find(value, curr.right)
    else
      curr
    end
  end

  def level_order_iterative
    return if @root.nil?

    nodes = []
    queue = []

    queue.push(@root)

    until queue.empty?
      curr = queue[0]
      block_given? ? (yield curr.data) : nodes << curr.data
      queue.push(curr.left) unless curr.left.nil?
      queue.push(curr.right) unless curr.right.nil?
      queue.shift
    end
    block_given? ? nil : nodes
  end

  def preorder(curr = @root, &block)
    return if curr.nil?

    yield curr.data
    preorder(curr.left, &block)
    preorder(curr.right, &block)
    curr
  end

  def inorder(curr = @root, &block)
    return if curr.nil?

    inorder(curr.left, &block)
    yield curr.data
    inorder(curr.right, &block)
    curr
  end

  def postorder(curr = @root, &block)
    return if curr.nil?

    postorder(curr.left, &block)
    postorder(curr.right, &block)
    yield curr.data
    curr
  end

  def height(curr)
    return -1 if curr.nil?

    [height(curr.left), height(curr.right)].max + 1
  end

  def depth(value, curr = @root)
    return nil if curr.nil?

    curr_depth = 0

    until curr.data == value
      if value < curr.data
        curr = curr.left
      elsif value > curr.data
        curr = curr.right
      else
        curr
      end
      curr_depth += 1
    end
    curr_depth
  end

  def balanced?(height, curr = @root)
    return -1 if curr.nil?

    left_height = balanced?(height, curr.left)
    right_height = balanced?(height, curr.right)

    return false if left_height.nil? || right_height.nil? || (left_height - right_height).abs > 1

    [left_height, right_height].max + 1
  end

  def rebalance
    nodes = level_order_iterative
    nodes.uniq! unless nodes.length == 1
    nodes.sort!
    build_tree(nodes)
  end
end
