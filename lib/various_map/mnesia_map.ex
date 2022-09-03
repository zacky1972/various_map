defmodule VariousMap.MnesiaMap do
  @moduledoc """
  A global map using Mnesia.
  """

  alias :mnesia, as: Mnesia

  @type t() :: atom()

  @on_load :init

  @doc false
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
  end

  @doc """
  Initialize `MnesiaMap` named as an atom `map`.
  """
  @spec init(t()) :: t()
  def init(map) do
    case Mnesia.create_table(map, attributes: [:key, :value]) do
      {:atomic, :ok} -> map
      {:aborted, {:already_exists, ^map}} -> map
      other -> raise RuntimeError, "reason: #{inspect(other)}"
    end
  end

  @doc """
  Gets the value for a specific `key` in `map`.

  If `key` is present in `map` then its value `value` is returned. Otherwise, `default` is returned.

  If `default` is not provided, `nil` is used.

  ## Examples

      iex> map = :mnesia_map
      iex> VariousMap.MnesiaMap.init(map)
      :mnesia_map
      iex> VariousMap.MnesiaMap.put(map, 1, "a")
      :mnesia_map
      iex> VariousMap.MnesiaMap.get(map, 1)
      "a"
      iex> VariousMap.MnesiaMap.get(map, 2)
      nil
      iex> VariousMap.MnesiaMap.get(map, 3, :default)
      :default
  """
  @spec get(t(), Map.key(), Map.value()) :: Map.value()
  def get(map, key, default \\ nil) do
    Mnesia.transaction(fn ->
      Mnesia.read({map, key})
    end)
    |> case do
      {:atomic, [{^map, ^key, value}]} -> value
      {:atomic, []} -> default
    end
  end

  @doc """
  Puts the given `value` under `key` in `map`.

  ## Examples

      iex> map = :mnesia_map
      iex> VariousMap.MnesiaMap.init(map)
      :mnesia_map
      iex> VariousMap.MnesiaMap.put(map, 1, "a")
      :mnesia_map
  """
  @spec put(t(), Map.key(), Map.value()) :: t()
  def put(map, key, value) do
    Mnesia.transaction(fn ->
      Mnesia.write({map, key, value})
    end)

    map
  end

  @doc """
  Delete `MnesiaMap` named as an atom `map`.
  """
  @spec delete(t()) :: t()
  def delete(map) do
    Mnesia.delete_table(map)
    map
  end
end
