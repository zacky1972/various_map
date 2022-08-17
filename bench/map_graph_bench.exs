import VariousMap.MapGraph

defmodule RandomMapGraph do
  def random_edges(v_size) do
    for v1 <- 1..v_size, v2 <- 1..v_size do
      {v1, v2, :rand.uniform(1000)}
    end
    |> Enum.shuffle()
  end

  def generate(edges, e_size) do
    edges
    |> Enum.take(e_size)
    |> Enum.reduce(%{}, fn {v1, v2, value}, graph ->
      put(graph, v1, v2, value)
    end)
  end

  def max_edges(v_size) do
    v_size * (v_size - 1)
  end
end

:rand.seed(:exsss, {100, 101, 102})

v_sizes = [10, 100, 1_000, 5_000]

random_edges =
  Enum.map(v_sizes, fn v_size ->
    {time, result} =
      :timer.tc(fn -> RandomMapGraph.random_edges(v_size) end)

    IO.puts("time of create random_edges: #{time / 1000}msec.")
    result
  end)

inputs =
  Enum.zip(v_sizes, random_edges)
  |> Enum.map(fn {v_size, edges} ->
    [v_size, v_size * 2, RandomMapGraph.max_edges(v_size)]
    |> Enum.map(fn e_size ->
      {
        "Graph {num_vertex, num_edge} = {#{v_size}, #{e_size}}",
        {
          {v_size, e_size},
          fn ->
            {time, result} =
              :timer.tc(fn -> RandomMapGraph.generate(edges, e_size) end)

            IO.puts("time of create MapGraph: #{time / 1000}msec")
            result
          end.()
        }
      }
    end)
  end)
  |> List.flatten()
  |> Map.new()

Benchee.run(
  %{
    "MapGraph.get" => fn {{v_size, _e_size}, input} ->
      get(input, :rand.uniform(v_size), :rand.uniform(v_size))
    end,
    "MapGraph.put" => fn {{v_size, _e_size}, input} ->
      put(input, :rand.uniform(v_size), :rand.uniform(v_size), :rand.uniform(1000))
    end
  },
  inputs: inputs
)
