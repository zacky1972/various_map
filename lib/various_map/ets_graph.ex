defmodule VariousMap.EtsGraph do
  @moduledoc """

  """

  @prefix "ets_graph"
  @global_ets :ets_g_global
  @type t() :: atom()
  @type vertex() :: pos_integer()
  @type value() :: any()
  @type t_edges() :: %{vertex() => value()}

  @doc """
    Initialize the `EtsGraph` system.
  """
  @spec init() :: :ok
  def init() do
    try do
      :ets.new(@global_ets, [:set, :public, :named_table])
    rescue
      ArgumentError -> :ok
    end

    :ok
  end

  @doc """
    Initialize `EtsGraph` named as an atom `graph` with the given size of vertexes `v_size`.
  """
  @spec init(atom, pos_integer()) :: t()
  def init(graph, v_size) do
    init()

    :ets.new(get_graph_atom(graph), [:set, :protected, :named_table])
    :ets.insert(@global_ets, {graph, v_size})
    graph
  end

  @doc """
  Delete `EtsGraph` named as an atom `graph`.
  """
  @spec delete(t()) :: t()
  def delete(graph) do
    :ets.delete(graph)
  end

  defp get_graph_atom(graph) do
    :"#{@prefix}_#{Atom.to_string(graph)}"
  end

  defp get_graph_size(graph) do
    case :ets.lookup(@global_ets, graph) do
      [] -> raise ArgumentError, "Graph #{graph} is not initialized."
      [{^graph, v_size}] -> v_size
    end
  end

  defp get_index(v_size, vertex1, vertex2) do
    v_size * (vertex1 - 1) + vertex2
  end

  @doc """
  Returns the value of the edge from `vertex1` to `vertex2` in `graph`.

  `vertex1` and `vertex2` should be positive integer values that are less than `v_size`
  If `graph` doesn't has such an edge, returns `default`.
  If `graph` isn't initialized, then raise `ArgumentError`.

  ## Examples
      iex> graph = :graph
      iex> VariousMap.EtsGraph.init(graph, 10)
      :graph
      iex> VariousMap.EtsGraph.get(graph, 1, 2)
      nil
      iex> VariousMap.EtsGraph.put(graph, 1, 2, "a")
      :graph
      iex> VariousMap.EtsGraph.get(graph, 1, 2)
      "a"
      iex> VariousMap.EtsGraph.get(graph, 2, 1, :empty)
      :empty
      iex> VariousMap.EtsGraph.put(graph, 1, 2, "b")
      :graph
      iex> VariousMap.EtsGraph.get(graph, 1, 2)
      "b"
  """
  @spec get(t(), vertex(), vertex(), value()) :: value()
  def get(graph, vertex1, vertex2, default \\ nil) do
    v_size = get_graph_size(graph)

    if v_size < vertex1 or v_size < vertex2 do
      raise ArgumentError, "Sizeout: (#{vertex1}, #[vertex2}) should be less than #{v_size}"
    end

    graph_atom = get_graph_atom(graph)
    index = get_index(v_size, vertex1, vertex2)

    case :ets.lookup(graph_atom, index) do
      [] -> default
      [{^index, value}] -> value
    end
  end

  @doc """
  Puts the given `value` under the edge from `vertex1` to `vertex2` in `graph`.

  `vertex1` and `vertex2` should be positive integer values that are less than `v_size`
  If `graph` doesn't has such an edge, returns `default`.
  If `graph` isn't initialized, then raise `ArgumentError`.

  ## Examples
      iex> graph = :graph
      iex> VariousMap.EtsGraph.init(graph, 10)
      :graph
      iex> VariousMap.EtsGraph.put(graph, 1, 2, "a")
      :graph
  """
  @spec put(t(), vertex(), vertex(), value()) :: t()
  def put(graph, vertex1, vertex2, value) do
    v_size = get_graph_size(graph)

    if v_size < vertex1 or v_size < vertex2 do
      raise ArgumentError, "Sizeout: (#{vertex1}, #[vertex2}) should be less than #{v_size}"
    end

    graph_atom = get_graph_atom(graph)
    index = get_index(v_size, vertex1, vertex2)
    :ets.insert(graph_atom, {index, value})
    graph
  end

  @doc """
  Return edges from the given `vertex` in `graph`.

  ## Examples
      iex> graph = :graph
      iex> VariousMap.EtsGraph.init(graph, 10)
      :graph
      iex> VariousMap.EtsGraph.put(graph, 1, 2, "a")
      :graph
      iex> VariousMap.EtsGraph.put(graph, 1, 3, "b")
      :graph
      iex> VariousMap.EtsGraph.edges(graph, 1)
      %{2 => "a", 3 => "b"}
  """
  @spec edges(t(), vertex()) :: t_edges()
  def edges(graph, vertex) do
    v_size = get_graph_size(graph)

    if v_size < vertex do
      raise ArgumentError, "Sizeout: #{vertex} should be less than #{v_size}"
    end

    graph_atom = get_graph_atom(graph)
    index_min = get_index(v_size, vertex, 1)
    index_max = index_min + v_size

    :ets.select(graph_atom, [
      {{:"$1", :"$2"}, [{:andalso, {:"=<", index_min, :"$1"}, {:"=<", :"$1", index_max}}],
       [:"$_"]}
    ])
    |> case do
      [] -> %{}

      list ->
        list
        |> Enum.map(fn {index, value} -> {index - index_min + 1, value} end)
        |> Map.new()
    end
  end
end
