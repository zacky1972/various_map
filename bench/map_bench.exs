defmodule RandomMap do
  def generate(size) do
    keys = Enum.shuffle(1..size)
    values = 1..size |> Enum.map(fn _ -> :rand.uniform(1000) end)

    Enum.zip(keys, values)
    |> Map.new()
  end
end

:rand.seed(:exsss, {100, 101, 102})

inputs =
  [10, 100, 1_000, 10_000, 100_000]
  |> Enum.map(
    &{
      "size #{&1}",
      RandomMap.generate(&1)
    }
  )
  |> Map.new()

Benchee.run(
  %{
    "Map get" => fn {input, size} ->
      Map.get(input, :rand.uniform(size))
      :ok
    end,
    "Map put" => fn {input, size} ->
      Map.put(input, :rand.uniform(size), :rand.uniform(1_000))
      :ok
    end
  },
  before_each: fn input -> {input, Enum.count(input)} end,
  inputs: inputs,
  print: [fast_warning: false]
)
