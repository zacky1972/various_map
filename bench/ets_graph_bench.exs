import VariousMap.EtsGraph

defmodule RandomEtsGraph do
  def random_edges(v_size) do
    for v1 <- 1..v_size, v2 <- 1..v_size do
      {v1, v2, :rand.uniform(1000)}
    end
    |> Enum.shuffle()
  end

  def generate(graph, edges, e_size) do
    init(graph)

    edges
    |> Enum.take(e_size)
    |> Enum.reduce(graph, fn {v1, v2, value}, graph ->
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
    {time, result} = :timer.tc(fn -> RandomEtsGraph.random_edges(v_size) end)

    IO.puts("time of create random_edges: #{time / 1000}msec.")
    result
  end)

inputs =
  Enum.zip(v_sizes, random_edges)
  |> Enum.map(fn {v_size, edges} ->
    [v_size, v_size * 2, RandomEtsGraph.max_edges(v_size)]
    |> Enum.map(fn e_size ->
      graph = :"graph_#{v_size}_#{e_size}"
      {time, _result} = :timer.tc(fn -> RandomEtsGraph.generate(graph, edges, e_size) end)
      IO.puts("time of create EtsGraph: #{time / 1000}msec")

      {
        "Graph {num_vertex, num_edge} = {#{v_size}, #{e_size}}",
        {v_size, e_size, graph}
      }
    end)
  end)
  |> List.flatten()
  |> Map.new()

Benchee.run(
  %{
    "EtsGraph.get" => fn {v_size, _e_size, graph} ->
      get(graph, :rand.uniform(v_size), :rand.uniform(v_size))
    end,
    "EtsGraph.put" => fn {v_size, _e_size, graph} ->
      put(graph, :rand.uniform(v_size), :rand.uniform(v_size), :rand.uniform(1000))
    end
  },
  inputs: inputs
)
