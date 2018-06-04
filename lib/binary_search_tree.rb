# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require "bst_node"

class BinarySearchTree

  attr_accessor :root

  def initialize(root = nil)
    @root = root
  end

  def insert(value, tree_node = @root)
    return @root = BSTNode.new(value) if @root.nil?
    if tree_node.value > value
      return tree_node.left = BSTNode.new(value) if tree_node.left.nil?
      return insert(value, tree_node.left)
    else
      return tree_node.right = BSTNode.new(value) if tree_node.right.nil?
      return insert(value, tree_node.right)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value
    if tree_node.value > value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    parentNode = findParent(value)
    currNode = find(value)
    # return @root = nil if currNode.value == @root
    if currNode.left.nil? && currNode.right.nil?
      return @root = nil if parentNode.nil?
      deleteChildFromParent(parentNode, currNode)
    elsif currNode.left && currNode.right.nil? ||
          currNode.left.nil? && currNode.right
      promoteGrandchild(parentNode, currNode)
    else
      maxNode = maximum(currNode.left)
      parentOfMax = findParent(maxNode.value)
      childOfMax = maxNode.left
      promoteMaxNode(currNode, maxNode, parentOfMax, childOfMax)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root, count = -1)
    return count if tree_node.nil?
    count += 1
    leftCount = depth(tree_node.left, count)
    rightCount = depth(tree_node.right, count)
    return [leftCount, rightCount].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    left = depth(tree_node.left)
    right = depth(tree_node.right)
    return false unless (left - right).abs <= 1
    is_balanced?(tree_node.left) && is_balanced?(tree_node.right) ? true : false
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)
  end


  private
  # optional helper methods go here:
  def findParent(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.left && tree_node.left.value == value
    return tree_node if tree_node.right && tree_node.right.value == value
    if tree_node.value > value
      findParent(value, tree_node.left)
    else
      findParent(value, tree_node.right)
    end
  end

  def deleteChildFromParent(parent, child)
    parent.left.value == child.value ? parent.left = nil : parent.right = nil
  end

  def promoteGrandchild(parent, child)
    grandChild = child.right.nil? ? child.left : child.right
    parent.left.value == child.value ? parent.left = grandChild : parent.right = grandChild
  end

  def promoteMaxNode(currNode, maxNode, parentOfMax, childOfMax)
    currNode.value = maxNode.value
    parentOfMax.right = childOfMax
  end
end
