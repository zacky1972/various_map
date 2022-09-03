defmodule RandomMnesiaMap do
  def generate(map, size) do
    keys = Enum.shuffle(1..size)
    values = 1..size |> Enum.map(fn _ -> :rand.uniform(1000) end)

    Enum.zip(keys, values)
    |> Enum.map(fn {k, v} ->
      VariousMap.MnesiaMap.put(map, k, v)
    end)
  end
end

:rand.seed(:exsss, {100, 101, 102})
map = :mnesia_map

inputs =
  [10, 100, 1_000, 10_000, 100_000]
  |> Enum.map(fn size ->
    {
      "size #{size}",
      size
    }
  end)

Benchee.run(
  %{
    "Mnesia Map get" => fn size ->
      VariousMap.MnesiaMap.get(map, :rand.uniform(size))
      :ok
    end,
    "Mnesia Map put" => fn size ->
      VariousMap.MnesiaMap.put(map, :rand.uniform(size), :rand.uniform(1_000))
      :ok
    end
  },
  before_each: fn size ->
    VariousMap.MnesiaMap.init(map)
    RandomMnesiaMap.generate(map, size)
    size
  end,
  after_each: fn _ -> VariousMap.MnesiaMap.delete(map) end,
  inputs: inputs,
  print: [fast_warning: false]
)
