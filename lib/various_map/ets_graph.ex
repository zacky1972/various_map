defmodule VariousMap.EtsGraph do
  @moduledoc """
  Global directed graph structure using ETS.
  """

  @global_maxid :ets_graph_global_maxid
  @type t() :: atom()
  @type t_edges() :: %{any() => any()}


  @doc """
  Initialize `EtsGraph` named as an atom `map`.
  """
  @spec init() :: :ok
  def init() do
    try do
      :ets.new(@global_maxid, [:set, :public, :named_table])
    rescue
      ArgumentError -> :ok
    end

    :ok
  end

  @spec init(t()) :: t()
  def init(graph) do
    init()

    case :ets.insert_new(@global_maxid, {graph, 0}) do
      true -> :ok
      false -> :ets.delete(graph)
    end

    :ets.new(graph, [:set, :protected, :named_table])
  end

  @doc """
  Return edges from the given `vertex` in `graph`.
  """
  @spec edges(t(), any()) :: t_edges()
  def edges(graph, vertex) do
    :ets.select(graph, [{{:"$1", :"$2", :"$3", :"$4"}, [{:==, :"$2", vertex}], [:"$_"]}])
    |> Enum.reduce(%{}, fn {_eid, _vertex1, vertex2, value}, result ->
      Map.put(result, vertex2, value)
    end)
  end

  @doc """
  Puts the given `value` under the edge from `vertex1` to `vertex2` in `graph`.

  ## Examples

      iex> graph = :graph
      iex> VariousMap.EtsGraph.init(graph)
      :graph
      iex> VariousMap.EtsGraph.put(graph, 1, 2, "a")
      :graph
  """
  @spec put(t(), any(), any(), any()) :: t()
  def put(graph, vertex1, vertex2, value) do
    case get_s(graph, vertex1, vertex2, nil) do
      {_, ^vertex1, ^vertex2, ^value} -> graph

      {_, ^vertex1, ^vertex2, nil} ->
        eid = :ets.update_counter(@global_maxid, graph, {2, 1})
        true = :ets.insert_new(graph, {eid, vertex1, vertex2, value})
        graph

      {eid, ^vertex1, ^vertex2, _} ->
        :ets.insert(graph, {eid, vertex1, vertex2, value})
        graph
    end
  end

  @doc """
  Returns the value of the edge from `vertex1` to `vertex2` in `graph`.

  If `graph` doesn't has such an edge, returns `default`.

  ## Examples
      iex> graph = :graph
      iex> VariousMap.EtsGraph.init(graph)
      :graph
      iex> VariousMap.EtsGraph.get(graph, 1, 2)
      nil

      iex> graph = :graph
      iex> VariousMap.EtsGraph.init(graph)
      :graph
      iex> VariousMap.EtsGraph.put(graph, 1, 2, "a")
      :graph
      iex> VariousMap.EtsGraph.get(graph, 1, 2)
      "a"
      iex> VariousMap.EtsGraph.put(graph, 1, 2, "b")
      :graph
      iex> VariousMap.EtsGraph.get(graph, 1, 2)
      "b"
      iex> VariousMap.EtsGraph.get(graph, 3, 4, :default)
      :default
  """
  @spec get(t(), any(), any(), any()) :: any()
  def get(graph, vertex1, vertex2, default \\ nil) do
    get_s(graph, vertex1, vertex2, default)
    |> elem(3)
  end

  defp get_s(graph, vertex1, vertex2, default) do
    :ets.select(graph, [
      {{:"$1", :"$2", :"$3", :"$4"}, [{:andalso, {:==, :"$2", vertex1}, {:==, :"$3", vertex2}}],
       [:"$_"]}
    ])
    |> case do
      [] ->
        {nil, vertex1, vertex2, default}

      [{eid, ^vertex1, ^vertex2, value}] ->
        {eid, vertex1, vertex2, value}

      list when is_list(list) ->
        raise RuntimeError, "duplicated edges #{inspect(list)}"
    end
  end
end
