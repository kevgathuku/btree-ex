defmodule BinaryTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, value), do: new(value)

  def insert(%{data: data, left: left, right: right} = tree, value) do
    cond do
      value < data ->
        %{data: data, left: insert(left, value), right: right}

      value > data ->
        %{data: data, left: left, right: insert(right, value)}

      value == data ->
        # Ignore the data and keep the tree as is
        tree
    end
  end

  def in_order(%{data: data, left: nil, right: nil}), do: [data]
  def in_order(%{data: data, left: left, right: nil}), do: in_order(left) ++ [data]
  def in_order(%{data: data, left: nil, right: right}), do: [data | in_order(right)]

  def in_order(%{data: data, left: left, right: right}),
    do: in_order(left) ++ [data] ++ in_order(right)

  @doc """
  Returns the height of the tree.

  Derived from https://stackoverflow.com/a/55770220/2390312
  """
  def height(%{left: nil, right: nil}), do: 0
  def height(%{left: nil, right: right}), do: 1 + height(right)
  def height(%{left: left, right: nil}), do: 1 + height(left)
  def height(%{left: left, right: right}), do: 1 + max(height(left), height(right))

  @doc """
  Return the minimum element in the binary search tree
  """
  def min(nil), do: nil
  def min(%{data: data, left: nil, right: _}), do: data
  def min(%{data: _, left: left, right: _}), do: min(left)

  @doc """
  Return the maximum element in the binary search tree
  """

  def max(nil), do: nil
  def max(%{data: data, left: nil, right: nil}), do: data
  def max(%{data: _, left: _, right: right}), do: max(right)

  @doc """
  Remove `value` from the binary tree and return the resulting tree
  """

  def delete(nil), do: nil

  def delete(%{data: data, left: left, right: right} = tree, value) do
    cond do
      value < data ->
        # Remove the target item from the left subtree
        Map.replace!(tree, :left, delete(tree.left, value))

      value > data ->
        Map.replace!(tree, :right, delete(tree.right, value))

      value == data ->
        cond do
          left == nil ->
            # Only a right subtree, or no subtrees
            # return the right sub-tree
            right

          right == nil ->
            # Only a left subtree, or no subtrees
            # return the left sub-tree
            left

          true ->
            # successor -> min value in right subtree / max value in the left subtree
            successor = min(right)
            %{data: successor, left: left, right: delete(right, successor)}
        end
    end
  end

  @doc """
  Checks if the tree is a binary search tree

  Conditions to check:
  The `data` value of every node in a node's left subtree is less than the data value of that node.
  The `data` value of every node in a node's right subtree is greater than the data value of that node.
  The `data` value of every node is distinct.

  Values for lower and upper obtained from:
  http://erlang.org/doc/efficiency_guide/advanced.html
  """
  def is_bst(root, lower \\ -134_217_729, upper \\ 134_217_728)
  def is_bst(nil, _lower, _upper), do: true
  def is_bst(%{left: nil, right: nil}, _lower, _upper), do: true

  def is_bst(%{data: data, left: nil, right: right}, _lower, upper) do
    is_bst(right, data + 1, upper)
  end

  def is_bst(%{data: data, left: left, right: nil}, lower, _upper) do
    cond do
      data < left[:data] ->
        false

      true ->
        is_bst(left, lower, data - 1)
    end
  end

  def is_bst(%{data: data, left: left, right: right}, lower, upper) do
    cond do
      data < left[:data] ->
        false

      data > right[:data] ->
        false

      true ->
        is_bst(left, lower, data - 1) and is_bst(right, data + 1, upper)
    end
  end

  def to_map(%{data: data, left: nil, right: nil}) do
    %{name: data}
  end

  def to_map(%{data: data, left: left, right: nil}) do
    Map.new([{:name, data}, {:children, [to_map(left)]}])
  end

  def to_map(%{data: data, left: nil, right: right}) do
    Map.new([{:name, data}, {:children, [to_map(right)]}])
  end

  def to_map(%{data: data, left: left, right: right}) do
    Map.new([{:name, data}, {:children, [to_map(left), to_map(right)]}])
  end
end
