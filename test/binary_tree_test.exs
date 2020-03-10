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

  test "rejects duplicates" do
    root =
      BinaryTree.new(4)
      |> BinaryTree.insert(4)
      |> BinaryTree.insert(4)

    assert root.data == 4
    assert root.left == nil
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
    root = BinaryTree.new(3)

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

  test "tree to map" do
    root = BinaryTree.new(3)

    assert %{name: 3} == BinaryTree.to_map(root)
  end

  test "complex tree to map" do
    root =
      BinaryTree.new(3)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(5)
      |> BinaryTree.insert(6)

    assert %{
             name: 3,
             children: [%{name: 2, children: [%{name: 1}]}, %{name: 5, children: [%{name: 6}]}]
           } == BinaryTree.to_map(root)
  end

  test "finds minimum value in simple tree" do
    root = BinaryTree.new(3)

    assert 3 == BinaryTree.min(root)
  end

  test "finds minimum value in complex tree" do
    root =
      BinaryTree.new(3)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(5)
      |> BinaryTree.insert(6)

    assert 1 == BinaryTree.min(root)
  end

  test "finds maximum value in a simple tree" do
    root = BinaryTree.new(3)

    assert 3 == BinaryTree.max(root)
  end

  test "finds maximum value in a complex tree" do
    root =
      BinaryTree.new(3)
      |> BinaryTree.insert(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(5)
      |> BinaryTree.insert(6)

    assert 6 == BinaryTree.max(root)
  end

  test "deletes a leaf node" do
    root = BinaryTree.new(3)

    assert root |> BinaryTree.delete(3) == nil
  end

  test "deletes a node with one child" do
    root =
      BinaryTree.new(2)
      |> BinaryTree.insert(1)
      |> BinaryTree.insert(7)
      |> BinaryTree.insert(4)
      |> BinaryTree.insert(8)
      |> BinaryTree.insert(3)
      |> BinaryTree.insert(6)
      |> BinaryTree.insert(5)

    assert root |> BinaryTree.delete(6) |> BinaryTree.in_order() == [1, 2, 3, 4, 5, 7, 8]
  end

  test "deletes from a tree with a left subtree and no right subtree" do
    root = %{data: 6, left: %{data: 5, left: nil, right: nil}, right: nil}

    assert BinaryTree.delete(root, 6) == root.left
  end

  test "deletes from a tree with a right subtree and no left subtree" do
    root = %{data: 6, right: %{data: 5, left: nil, right: nil}, left: nil}

    assert BinaryTree.delete(root, 6) == root.right
  end
end
