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
  def insert(nil, value), do: new(value)

  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: data, left: left, right: right}, value) do
    cond do
      value <= data ->
        %{data: data, left: insert(left, value), right: right}

      value > data ->
        %{data: data, left: left, right: insert(right, value)}
    end
  end

  def in_order(%{data: data, left: nil, right: nil}), do: [data]
  def in_order(%{data: data, left: left, right: nil}), do: in_order(left) ++ [data]
  def in_order(%{data: data, left: nil, right: right}), do: [data | in_order(right)]

  def in_order(%{data: data, left: left, right: right}),
    do: in_order(left) ++ [data] ++ in_order(right)

  # Derived from https://stackoverflow.com/a/55770220/2390312
  def height(%{left: nil, right: nil}), do: 0
  def height(%{left: nil, right: right}), do: 1 + height(right)
  def height(%{left: left, right: nil}), do: 1 + height(left)
  def height(%{left: left, right: right}), do: 1 + max(height(left), height(right))
end
