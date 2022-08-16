defmodule VariousMap.MapGraph do
  @moduledoc """
  Graph structure using Map.
  """

  @type t_edges() :: %{any() => any()}
  @type t() :: %{any() => t_edges()}

  @doc """
  Return edges from the given `vertex` in `graph`.
  """
  @spec edges(t(), any()) :: t_edges()
  def edges(graph, vertex) do
    Map.get(graph, vertex, %{})
  end

  @doc """
  Puts the given `value` under the edge from `vertex1` to `vertex2` in `graph`.

  ## Examples

      iex> VariousMap.MapGraph.put(%{}, 1, 2, "a")
      %{1 => %{2 => "a"}}

      iex> VariousMap.MapGraph.put(%{1 => %{2 => "a"}}, 3, 4, "b")
      %{1 => %{2 => "a"}, 3 => %{4 => "b"}}

      iex> VariousMap.MapGraph.put(%{1 => %{2 => "a"}, 3 => %{4 => "b"}}, 1, 2, "c")
      %{1 => %{2 => "c"}, 3 => %{4 => "b"}}

      iex> VariousMap.MapGraph.put(%{1 => %{2 => "a"}, 3 => %{4 => "b"}}, 2, 1, "c")
      %{1 => %{2 => "a"}, 2 => %{1 => "c"}, 3 => %{4 => "b"}}
  """
  @spec put(t(), any(), any(), any()) :: t()
  def put(graph, vertex1, vertex2, value) do
    e = edges(graph, vertex1)
    Map.put(graph, vertex1, Map.put(e, vertex2, value))
  end

  @doc """
  Returns the value of the edge from `vertex1` to `vertex2` in `graph`.

  If `graph` doesn't has such an edge, returns `default`.

  ## Examples
      iex> VariousMap.MapGraph.get(%{}, 1, 2)
      nil

      iex> VariousMap.MapGraph.get(%{1 => %{2 => "a"}}, 1, 2)
      "a"

      iex> VariousMap.MapGraph.get(%{1 => %{2 => "a"}}, 3, 4, :default)
      :default
  """
  @spec get(t(), any(), any(), any()) :: any()
  def get(graph, vertex1, vertex2, default \\ nil) do
    Map.get(edges(graph, vertex1), vertex2, default)
  end
end
