defmodule VariousMap.EtsGraph do
  @moduledoc """

  """

  @prefix "ets_graph"
  @global_ets :ets_g_global
  @type t() :: atom()

  @doc """
    Initialize the `EtsGraph` system.
  """
  @spec init() :: t()
  def init() do
    try do
      :ets.new(@global_ets, [:set, :public, :named_table])
    rescue
      ArgumentError -> :ok
    end
    :ok
  end

  @doc """
    Initialize `EtsGraph` named as an atom `graph`.
  """
  @spec init(atom, pos_integer()) :: t()
  def init(graph, v_size) do
    init()

    :ets.new(get_graph_atom(graph), [:set, :protected, :named_table])
    :ets.insert(@global_ets, {graph, v_size})
  end

  @doc """
  Delete `EtsGraph` named as an atom `map`.
  """
  @spec delete(t()) :: t()
  def delete(graph) do
    :ets.delete(graph)
  end

  defp get_graph_atom(graph) do
    :"#{@prefix}_#{Atom.to_string(graph)}"
  end
end
