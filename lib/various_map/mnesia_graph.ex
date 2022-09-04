defmodule VariousMap.MnesiaGraph do
  @moduledoc """
  Global directed graph structure using Mnesia.
  """

  alias :mnesia, as: Mnesia

  @prefix "mnesia_graph"
  @global_mnesia :mnesia_g_global
  @type t() :: atom()
  @type vertex() :: pos_integer()
  @type value() :: any()
  @type t_edges() :: %{vertex() => value()}

  @on_load :init

  @doc false
  @spec init() :: :ok
  def init() do
    case Mnesia.create_schema([node()]) do
      :ok -> :ok
      {:error, {_, {:already_exists, _}}} -> :ok
      other -> other
    end
    |> case do
      :ok -> Mnesia.start()
      _ -> :error
    end
    |> case do
      :ok -> Mnesia.create_table(@global_mnesia, attributes: [:graph, :v_size])
    end
    |> case do
      {:atomic, :ok} -> :ok
      {:aborted, {:already_exists, @global_mnesia}} -> :ok
      _ -> :error
    end
  end

  @doc """
  Initialize `MnesiaGraph` named as an atom `graph` with the given size of vertexes `v_size`.
  """
  @spec init(t(), pos_integer()) :: t()
  def init(graph, v_size) do
    Mnesia.delete_table(get_graph_atom(graph))
    Mnesia.create_table(get_graph_atom(graph), attributes: [:index, :value])
    Mnesia.add_table_index(get_graph_atom(graph), :index)

    Mnesia.transaction(fn ->
      Mnesia.write({@global_mnesia, graph, v_size})
    end)

    graph
  end

  defp get_graph_atom(graph) do
    :"#{@prefix}_#{Atom.to_string(graph)}"
  end

  @doc """
  Delete `MnesiaGraph` named as an atom `graph`.
  """
  @spec delete(t()) :: t()
  def delete(graph) do
    Mnesia.transaction(fn ->
      Mnesia.delete({@global_mnesia, graph})
    end)

    Mnesia.delete_table(get_graph_atom(graph))
    graph
  end

  defp get_graph_size(graph) do
    Mnesia.transaction(fn ->
      Mnesia.read({@global_mnesia, graph})
    end)
    |> case do
      {:atomic, []} -> raise ArgumentError, "Graph #{graph} is not initialized."
      {:atomic, [{@global_mnesia, ^graph, v_size}]} -> v_size
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
      iex> VariousMap.MnesiaGraph.init(graph, 10)
      :graph
      iex> VariousMap.MnesiaGraph.get(graph, 1, 2)
      nil
      iex> VariousMap.MnesiaGraph.put(graph, 1, 2, "a")
      :graph
      iex> VariousMap.MnesiaGraph.get(graph, 1, 2)
      "a"
      iex> VariousMap.MnesiaGraph.get(graph, 2, 1, :empty)
      :empty
      iex> VariousMap.MnesiaGraph.put(graph, 1, 2, "b")
      :graph
      iex> VariousMap.MnesiaGraph.get(graph, 1, 2)
      "b"
  """
  @spec get(t(), vertex(), vertex(), value()) :: value()
  def get(graph, vertex1, vertex2, default \\ nil) do
    v_size = get_graph_size(graph)

    if v_size < vertex1 or v_size < vertex2 do
      raise ArgumentError, "Sizeout: (#{vertex1}, #{vertex2}) should be less than #{v_size}"
    end

    graph_atom = get_graph_atom(graph)
    index = get_index(v_size, vertex1, vertex2)

    Mnesia.transaction(fn ->
      Mnesia.read({graph_atom, index})
    end)
    |> case do
      {:atomic, []} -> default
      {:atomic, [{^graph_atom, ^index, value}]} -> value
    end
  end

  @doc """
  Puts the given `value` under the edge from `vertex1` to `vertex2` in `graph`.

  `vertex1` and `vertex2` should be positive integer values that are less than `v_size`
  If `graph` doesn't has such an edge, returns `default`.
  If `graph` isn't initialized, then raise `ArgumentError`.

  ## Examples
      iex> graph = :graph
      iex> VariousMap.MnesiaGraph.init(graph, 10)
      :graph
      iex> VariousMap.MnesiaGraph.put(graph, 1, 2, "a")
      :graph
  """
  @spec put(t(), vertex(), vertex(), value()) :: t()
  def put(graph, vertex1, vertex2, value) do
    v_size = get_graph_size(graph)

    if v_size < vertex1 or v_size < vertex2 do
      raise ArgumentError, "Sizeout: (#{vertex1}, #{vertex2}) should be less than #{v_size}"
    end

    graph_atom = get_graph_atom(graph)
    index = get_index(v_size, vertex1, vertex2)

    Mnesia.transaction(fn ->
      Mnesia.write({graph_atom, index, value})
    end)

    graph
  end

  @doc """
  Return edges from the given `vertex` in `graph`.

  ## Examples
      iex> graph = :graph
      iex> VariousMap.MnesiaGraph.init(graph, 10)
      :graph
      iex> VariousMap.MnesiaGraph.put(graph, 1, 2, "a")
      :graph
      iex> VariousMap.MnesiaGraph.put(graph, 1, 3, "b")
      :graph
      iex> VariousMap.MnesiaGraph.edges(graph, 1)
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

    Mnesia.transaction(fn ->
      Mnesia.select(graph_atom, [{{graph_atom, :"$1", :"$2"}, [{:andalso, {:"=<", index_min, :"$1"}, {:"=<", :"$1", index_max}}], [:"$$"]}])
    end)
    |> case do
      {:atomic, []} -> %{}

      {:atomic, list} ->
        list
        |> Enum.map(fn [index, value] -> {index - index_min + 1, value} end)
        |> Map.new()
    end
  end
end
