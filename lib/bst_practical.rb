require "binary_search_tree"

def kth_largest(tree_node, k)
  bst = BinarySearchTree.new
  traversed = bst.in_order_traversal(tree_node)
  bst.find(traversed[traversed.length-k], tree_node)
end
