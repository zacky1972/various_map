defmodule VariousMap.EtsMap do
  @moduledoc """
  A global map using ETS.
  """

  alias :ets, as: Ets

  @type t() :: atom()

  @doc """
  Initialize `EtsMap` named as an atom `map`.
  """
  @spec init(t()) :: t()
  def init(map) do
    Ets.new(map, [:set, :protected, :named_table])
  end

  @doc """
  Gets the value for a specific `key` in `map`.

  If `key` is present in `map` then its value `value` is returned. Otherwise, `default` is returned.

  If `default` is not provided, `nil` is used.

  ## Examples

      iex> map = :map
      iex> VariousMap.EtsMap.init(map)
      :map
      iex> VariousMap.EtsMap.put(map, 1, "a")
      :map
      iex> VariousMap.EtsMap.get(map, 1)
      "a"
      iex> VariousMap.EtsMap.get(map, 2)
      nil
      iex> VariousMap.EtsMap.get(map, 3, :default)
      :default
  """
  @spec get(t(), Map.key(), Map.value()) :: Map.value()
  def get(map, key, default \\ nil) do
    case Ets.lookup(map, key) do
      [] -> default
      [{^key, value}] -> value
    end
  end

  @doc """
  Puts the given `value` under `key` in `map`.

  ## Examples

      iex> map = :map
      iex> VariousMap.EtsMap.init(map)
      :map
      iex> VariousMap.EtsMap.put(map, 1, "a")
      :map
  """
  @spec put(t(), Map.key(), Map.value()) :: t()
  def put(map, key, value) do
    Ets.insert(map, {key, value})
    map
  end

  @doc """
  Delete `EtsMap` named as an atom `map`.
  """
  @spec delete(t()) :: t()
  def delete(map) do
    Ets.delete(map)
  end
end
