defmodule BinaryTreeTest do
  use ExUnit.Case

  test "retains data" do
    assert BinaryTree.new(4).data == 4
  end

  test "inserting lower number" do
    root =
      BinaryTree.new(4)
      |> BinaryTree.insert(2)

    assert root.data == 4
    assert root.left.data == 2
  end

  test "inserting same number" do
    # Allows duplicate values
    root =
      BinaryTree.new(4)
      |> BinaryTree.insert(4)

    assert root.data == 4
    assert root.left.data == 4
  end

  test "inserting higher number" do
    root =
      BinaryTree.new(4)
      |> BinaryTree.insert(5)

    assert root.data == 4
    assert root.right.data == 5
  end

  test "insert into a complex tree" do
    root =
      BinaryTree.new(4)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(6)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(3)
      |> BinaryTree.insert(7)
      |> BinaryTree.insert(5)

    assert root.data == 4
    assert root.left.data == 2
    assert root.left.left.data == 1
    assert root.left.right.data == 3
    assert root.right.data == 6
    assert root.right.left.data == 5
    assert root.right.right.data == 7
  end

  test "iterating one element" do
    root = BinaryTree.new(4)

    assert [4] == BinaryTree.in_order(root)
  end

  test "iterating over smaller element" do
    root =
      BinaryTree.new(4)
      |> BinaryTree.insert(2)

    assert [2, 4] == BinaryTree.in_order(root)
  end

  test "iterating over larger element" do
    root =
      BinaryTree.new(4)
      |> BinaryTree.insert(5)

    assert [4, 5] == BinaryTree.in_order(root)
  end

  test "iterating over complex tree" do
    root =
      BinaryTree.new(4)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(3)
      |> BinaryTree.insert(6)
      |> BinaryTree.insert(7)
      |> BinaryTree.insert(5)

    assert [1, 2, 3, 4, 5, 6, 7] == BinaryTree.in_order(root)
  end

  test "height of one-element tree" do
    root = BinaryTree.new(4)

    assert 0 == BinaryTree.height(root)
  end

  test "height of 5-element tree" do
    root =
      BinaryTree.new(3)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(7)
      |> BinaryTree.insert(5)
      |> BinaryTree.insert(4)

    assert 3 == BinaryTree.height(root)
  end

  test "height of larger tree" do
    root =
      BinaryTree.new(3)
      |> BinaryTree.insert(5)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(4)
      |> BinaryTree.insert(6)
      |> BinaryTree.insert(7)
      |> BinaryTree.insert(10)

    assert 4 == BinaryTree.height(root)
  end

  test "tree with no leaves is binary search " do
    root =
      BinaryTree.new(3)

    assert true == BinaryTree.is_bst(root)
  end

  test "is binary search tree complex tree" do
    root =
      BinaryTree.new(3)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(5)
      |> BinaryTree.insert(4)
      |> BinaryTree.insert(6)

    assert true == BinaryTree.is_bst(root)
  end

  test "tree with repeated values on the left is not a binary search tree" do
    root =
      BinaryTree.new(3)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(5)
      |> BinaryTree.insert(6)
      |> BinaryTree.insert(1)

    assert false == BinaryTree.is_bst(root)
  end

  test "tree with repeated values on the right is not a binary search tree" do
    root =
      BinaryTree.new(3)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(5)
      |> BinaryTree.insert(6)
      |> BinaryTree.insert(6)

    assert false == BinaryTree.is_bst(root)
  end
end
