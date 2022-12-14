# VariousMap

Map implementations in various ways.

## Installation

You can add `various_map` as dependencies in your `mix.exs`. At the moment you will have to use a Git dependency while we work on our first release:

```elixir
def deps do
  [
    {:various_map, "~> 0.1", github: "zacky1972/various_map"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) by `mix docs`.

## Usage

### Benchmarks of Map

Run `mix run -r bench/map_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/map_bench.exs
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 24 GB
Elixir 1.14.0
Erlang 25.0.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: size 10, size 100, size 1000, size 10000, size 100000
Estimated total run time: 1.17 min

Benchmarking Map get with input size 10 ...
Benchmarking Map get with input size 100 ...
Benchmarking Map get with input size 1000 ...
Benchmarking Map get with input size 10000 ...
Benchmarking Map get with input size 100000 ...
Benchmarking Map put with input size 10 ...
Benchmarking Map put with input size 100 ...
Benchmarking Map put with input size 1000 ...
Benchmarking Map put with input size 10000 ...
Benchmarking Map put with input size 100000 ...

##### With input size 10 #####
Name              ips        average  deviation         median         99th %
Map get       13.88 M       72.05 ns ±21396.29%          42 ns          84 ns
Map put        6.98 M      143.27 ns  ±2200.77%      120.90 ns      162.50 ns

Comparison: 
Map get       13.88 M
Map put        6.98 M - 1.99x slower +71.22 ns

##### With input size 100 #####
Name              ips        average  deviation         median         99th %
Map get       11.14 M       89.78 ns ±15571.08%          83 ns         125 ns
Map put        8.60 M      116.29 ns ±20030.50%          83 ns         125 ns

Comparison: 
Map get       11.14 M
Map put        8.60 M - 1.30x slower +26.51 ns

##### With input size 1000 #####
Name              ips        average  deviation         median         99th %
Map get       10.92 M       91.54 ns ±14534.79%          83 ns         125 ns
Map put        7.95 M      125.78 ns ±25238.19%          83 ns         125 ns

Comparison: 
Map get       10.92 M
Map put        7.95 M - 1.37x slower +34.24 ns

##### With input size 10000 #####
Name              ips        average  deviation         median         99th %
Map get        9.11 M      109.80 ns ±13974.75%          83 ns         125 ns
Map put        8.09 M      123.65 ns ±24992.66%          83 ns         125 ns

Comparison: 
Map get        9.11 M
Map put        8.09 M - 1.13x slower +13.85 ns

##### With input size 100000 #####
Name              ips        average  deviation         median         99th %
Map get        8.16 M      122.55 ns ±15375.64%          84 ns         209 ns
Map put        6.86 M      145.67 ns  ±2532.76%      120.90 ns      162.50 ns

Comparison: 
Map get        8.16 M
Map put        6.86 M - 1.19x slower +23.12 ns
```

The operations of `Map.get/3` and `Map.put/3` work in logarithmic time, which means that the time it takes to find keys grows as the map grows, but it's not directly proportional to the map size. 

The results show the growth of the execution time of the operations seems to be very gentle, even considering that they work in logarithmic time.

`Map` is 12.1-18.2x and 77.4-119x faster than `VariousMap.EtsMap` and `VariousMap.MnesiaMap`, respectively.

### EtsMap and Benchmark of it

`VariousMap.EtsMap` is a module compatible to `Map` but using ETS.


Run `mix run -r bench/ets_map_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/ets_map_bench.exs
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 24 GB
Elixir 1.14.0
Erlang 25.0.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: size 10, size 100, size 1000, size 10000, size 100000
Estimated total run time: 1.17 min

Benchmarking ETS Map get with input size 10 ...
Benchmarking ETS Map get with input size 100 ...
Benchmarking ETS Map get with input size 1000 ...
Benchmarking ETS Map get with input size 10000 ...
Benchmarking ETS Map get with input size 100000 ...
Benchmarking ETS Map put with input size 10 ...
Benchmarking ETS Map put with input size 100 ...
Benchmarking ETS Map put with input size 1000 ...
Benchmarking ETS Map put with input size 10000 ...
Benchmarking ETS Map put with input size 100000 ...

##### With input size 10 #####
Name                  ips        average  deviation         median         99th %
ETS Map get      367.06 K        2.72 μs    ±11.40%        2.67 μs        3.49 μs
ETS Map put      358.20 K        2.79 μs    ±10.34%        2.75 μs        3.63 μs

Comparison: 
ETS Map get      367.06 K
ETS Map put      358.20 K - 1.02x slower +0.0674 μs

##### With input size 100 #####
Name                  ips        average  deviation         median         99th %
ETS Map get       10.11 M      0.0989 μs    ±37.50%      0.0840 μs       0.125 μs
ETS Map put      0.0415 M       24.11 μs     ±3.89%       23.80 μs       26.77 μs

Comparison: 
ETS Map get       10.11 M
ETS Map put      0.0415 M - 243.84x slower +24.01 μs

##### With input size 1000 #####
Name                  ips        average  deviation         median         99th %
ETS Map get        2.92 K      342.08 μs     ±1.93%      341.70 μs      357.35 μs
ETS Map put        2.91 K      343.56 μs     ±2.44%      341.52 μs      367.19 μs

Comparison: 
ETS Map get        2.92 K
ETS Map put        2.91 K - 1.00x slower +1.48 μs

##### With input size 10000 #####
Name                  ips        average  deviation         median         99th %
ETS Map get        260.82        3.83 ms     ±4.39%        3.82 ms        5.15 ms
ETS Map put        258.13        3.87 ms     ±1.33%        3.88 ms        4.02 ms

Comparison: 
ETS Map get        260.82
ETS Map put        258.13 - 1.01x slower +0.0399 ms

##### With input size 100000 #####
Name                  ips        average  deviation         median         99th %
ETS Map put      566.85 K        1.76 μs    ±82.06%        0.71 μs        5.14 μs
ETS Map get      447.76 K        2.23 μs    ±63.62%        2.50 μs        5.19 μs

Comparison: 
ETS Map put      566.85 K
ETS Map get      447.76 K - 1.27x slower +0.47 μs
```

`VariousMap.EtsMap` is 12.1-18.2x slower than `Map`.
`VariousMap.EtsMap` is 6.40-6.51x faster than `VariousMap.MnesiaMap`.

### MnesiaMap and Benchmark of it

`VariousMap.MnesiaMap` is a module compatible to `Map` but using Mnesia.

Run `mix run -r bench/mnesia_map_bench.exs`, then you'll get results similar to the following:

```
 % mix run -r bench/mnesia_map_bench.exs
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 24 GB
Elixir 1.14.0
Erlang 25.0.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: size 10, size 100, size 1000, size 10000, size 100000
Estimated total run time: 1.17 min

Benchmarking Mnesia Map get with input size 10 ...
Benchmarking Mnesia Map get with input size 100 ...
Benchmarking Mnesia Map get with input size 1000 ...
Benchmarking Mnesia Map get with input size 10000 ...
Benchmarking Mnesia Map get with input size 100000 ...
Benchmarking Mnesia Map put with input size 10 ...
Benchmarking Mnesia Map put with input size 100 ...
Benchmarking Mnesia Map put with input size 1000 ...
Benchmarking Mnesia Map put with input size 10000 ...
Benchmarking Mnesia Map put with input size 100000 ...

##### With input size 10 #####
Name                     ips        average  deviation         median         99th %
Mnesia Map put       91.70 K       10.90 μs    ±13.83%       10.67 μs       18.70 μs
Mnesia Map get       90.34 K       11.07 μs    ±13.04%       10.83 μs       18.11 μs

Comparison: 
Mnesia Map put       91.70 K
Mnesia Map get       90.34 K - 1.02x slower +0.165 μs

##### With input size 100 #####
Name                     ips        average  deviation         median         99th %
Mnesia Map put       88.46 K       11.30 μs    ±26.82%        9.88 μs       21.53 μs
Mnesia Map get       86.74 K       11.53 μs    ±27.53%       10.50 μs       22.88 μs

Comparison: 
Mnesia Map put       88.46 K
Mnesia Map get       86.74 K - 1.02x slower +0.22 μs

##### With input size 1000 #####
Name                     ips        average  deviation         median         99th %
Mnesia Map put       96.27 K       10.39 μs    ±19.80%        9.75 μs       19.92 μs
Mnesia Map get       91.63 K       10.91 μs    ±15.61%       10.17 μs       17.70 μs

Comparison: 
Mnesia Map put       96.27 K
Mnesia Map get       91.63 K - 1.05x slower +0.53 μs

##### With input size 10000 #####
Name                     ips        average  deviation         median         99th %
Mnesia Map put      104.36 K        9.58 μs    ±37.39%        8.46 μs       29.58 μs
Mnesia Map get       95.75 K       10.44 μs    ±26.64%        9.52 μs       25.75 μs

Comparison: 
Mnesia Map put      104.36 K
Mnesia Map get       95.75 K - 1.09x slower +0.86 μs

##### With input size 100000 #####
Name                     ips        average  deviation         median         99th %
Mnesia Map put       88.56 K       11.29 μs    ±23.40%       10.29 μs          16 μs
Mnesia Map get       68.77 K       14.54 μs    ±10.44%       14.96 μs       15.96 μs

Comparison: 
Mnesia Map put       88.56 K
Mnesia Map get       68.77 K - 1.29x slower +3.25 μs
```

`VariousMap.MnesiaMap` is 77.4-119x and 6.40-6.51x slower than `Map` and `VariousMap.EtsMap`, respectively.


### MapGraph and Benchmark of it

`VariousMap.MapGraph` is a module for a graph that can use for both a directed and a undirected graph using `Map`.


Run `mix run -r bench/map_graph_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/map_graph_bench.exs 
time of create random_edges: 0.562msec.
time of create random_edges: 2.969msec.
time of create random_edges: 602.218msec.
time of create random_edges: 24840.19msec.
time of create MapGraph: 0.007msec
time of create MapGraph: 0.001msec
time of create MapGraph: 0.012msec
time of create MapGraph: 0.017msec
time of create MapGraph: 0.028msec
time of create MapGraph: 2.025msec
time of create MapGraph: 0.157msec
time of create MapGraph: 0.311msec
time of create MapGraph: 817.008msec
time of create MapGraph: 1.718msec
time of create MapGraph: 2.562msec
time of create MapGraph: 22880.225msec
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 24 GB
Elixir 1.14.0
Erlang 25.0.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: Graph {num_vertex, num_edge} = {10, 10}, Graph {num_vertex, num_edge} = {10, 20}, Graph {num_vertex, num_edge} = {10, 90}, Graph {num_vertex, num_edge} = {100, 100}, Graph {num_vertex, num_edge} = {100, 200}, Graph {num_vertex, num_edge} = {100, 9900}, Graph {num_vertex, num_edge} = {1000, 1000}, Graph {num_vertex, num_edge} = {1000, 2000}, Graph {num_vertex, num_edge} = {1000, 999000}, Graph {num_vertex, num_edge} = {5000, 10000}, Graph {num_vertex, num_edge} = {5000, 24995000}, Graph {num_vertex, num_edge} = {5000, 5000}
Estimated total run time: 2.80 min

Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {10, 10} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {10, 20} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {10, 90} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {100, 100} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {100, 200} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {100, 9900} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {1000, 1000} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {1000, 2000} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {1000, 999000} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {5000, 10000} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {5000, 24995000} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {5000, 5000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {10, 10} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {10, 20} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {10, 90} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {100, 100} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {100, 200} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {100, 9900} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {1000, 1000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {1000, 2000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {1000, 999000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {5000, 10000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {5000, 24995000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {5000, 5000} ...

##### With input Graph {num_vertex, num_edge} = {10, 10} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get       10.63 M       94.05 ns ±25752.82%          83 ns         166 ns
MapGraph.put        4.27 M      234.29 ns ±24652.22%         166 ns         333 ns

Comparison: 
MapGraph.get       10.63 M
MapGraph.put        4.27 M - 2.49x slower +140.24 ns

##### With input Graph {num_vertex, num_edge} = {10, 20} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.44 M      225.10 ns ±61686.85%          83 ns         125 ns
MapGraph.put        2.87 M      348.55 ns ±29631.32%         167 ns         334 ns

Comparison: 
MapGraph.get        4.44 M
MapGraph.put        2.87 M - 1.55x slower +123.45 ns

##### With input Graph {num_vertex, num_edge} = {10, 90} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.01 M      249.12 ns ±57871.76%          83 ns         125 ns
MapGraph.put        3.22 M      310.66 ns ±20983.83%         167 ns         334 ns

Comparison: 
MapGraph.get        4.01 M
MapGraph.put        3.22 M - 1.25x slower +61.54 ns

##### With input Graph {num_vertex, num_edge} = {100, 100} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        3.81 M      262.67 ns ±55318.78%          84 ns         167 ns
MapGraph.put        3.11 M      321.91 ns ±21244.53%         208 ns        1083 ns

Comparison: 
MapGraph.get        3.81 M
MapGraph.put        3.11 M - 1.23x slower +59.25 ns

##### With input Graph {num_vertex, num_edge} = {100, 200} #####
Name                   ips        average  deviation         median         99th %
MapGraph.put        3.07 M      325.28 ns ±18568.61%         209 ns         375 ns
MapGraph.get        3.03 M      330.42 ns ±42673.45%         125 ns         209 ns

Comparison: 
MapGraph.put        3.07 M
MapGraph.get        3.03 M - 1.02x slower +5.14 ns

##### With input Graph {num_vertex, num_edge} = {100, 9900} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        6.65 M      150.45 ns ±44246.77%         125 ns         208 ns
MapGraph.put        2.66 M      375.39 ns ±22716.75%         250 ns         500 ns

Comparison: 
MapGraph.get        6.65 M
MapGraph.put        2.66 M - 2.50x slower +224.94 ns

##### With input Graph {num_vertex, num_edge} = {1000, 1000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        8.83 M      113.20 ns    ±30.55%         125 ns         167 ns
MapGraph.put        2.84 M      351.72 ns ±15344.77%         250 ns        1125 ns

Comparison: 
MapGraph.get        8.83 M
MapGraph.put        2.84 M - 3.11x slower +238.52 ns

##### With input Graph {num_vertex, num_edge} = {1000, 2000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        6.37 M      157.11 ns ±46602.02%         125 ns         167 ns
MapGraph.put        2.56 M      391.06 ns ±23783.38%         250 ns        1250 ns

Comparison: 
MapGraph.get        6.37 M
MapGraph.put        2.56 M - 2.49x slower +233.95 ns

##### With input Graph {num_vertex, num_edge} = {1000, 999000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        2.06 M      485.63 ns ±29438.06%         250 ns         583 ns
MapGraph.put        1.79 M      557.52 ns ±10558.53%         458 ns        1458 ns

Comparison: 
MapGraph.get        2.06 M
MapGraph.put        1.79 M - 1.15x slower +71.89 ns

##### With input Graph {num_vertex, num_edge} = {5000, 10000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        6.28 M      159.29 ns ±44283.03%         125 ns         208 ns
MapGraph.put        2.47 M      405.52 ns ±21239.02%         292 ns        1292 ns

Comparison: 
MapGraph.get        6.28 M
MapGraph.put        2.47 M - 2.55x slower +246.23 ns

##### With input Graph {num_vertex, num_edge} = {5000, 24995000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.put        1.34 M      744.50 ns  ±3462.61%         709 ns        1167 ns
MapGraph.get        1.32 M      760.03 ns ±33377.01%         542 ns         875 ns

Comparison: 
MapGraph.put        1.34 M
MapGraph.get        1.32 M - 1.02x slower +15.52 ns

##### With input Graph {num_vertex, num_edge} = {5000, 5000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        6.48 M      154.35 ns ±46204.45%         125 ns         208 ns
MapGraph.put        2.64 M      378.96 ns ±26497.26%         250 ns        1250 ns

Comparison: 
MapGraph.get        6.48 M
MapGraph.put        2.64 M - 2.46x slower +224.62 ns
```

1. The maximum number of edges when the number of vertexes is 5,000 is 24,995,000. 
2. The average execution time of `MapGraph.put` in this case is 760.03 ns.
3. Then, total execution time of `MapGraph.put` when generating the graph in this case is 18,996.9 msec.
4. But, total execution time of generating the graph in this case is 22,880.225 msec.
5. About 83% is the ratio of generating the graph to `MapGraph.put`, and about 17% is some overheads. What does the overheads arise from?

### EtsGraph and Benchmark of it

`VariousMap.EtsGraph` is a module for a global graph that can use for a directed graph using ETS.


Run `mix run -r bench/ets_graph_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/ets_graph_bench.exs 
time of create random_edges: 0.431msec.
time of create random_edges: 2.596msec.
time of create random_edges: 566.238msec.
time of create random_edges: 23104.238msec.
time of create EtsGraph: 0.016msec
time of create EtsGraph: 0.009msec
time of create EtsGraph: 0.024msec
time of create EtsGraph: 0.023msec
time of create EtsGraph: 0.044msec
time of create EtsGraph: 2.557msec
time of create EtsGraph: 0.248msec
time of create EtsGraph: 0.516msec
time of create EtsGraph: 419.51msec
time of create EtsGraph: 2.238msec
time of create EtsGraph: 3.499msec
time of create EtsGraph: 21322.16msec
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 24 GB
Elixir 1.14.0
Erlang 25.0.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: Graph {num_vertex, num_edge} = {10, 10}, Graph {num_vertex, num_edge} = {10, 20}, Graph {num_vertex, num_edge} = {10, 90}, Graph {num_vertex, num_edge} = {100, 100}, Graph {num_vertex, num_edge} = {100, 200}, Graph {num_vertex, num_edge} = {100, 9900}, Graph {num_vertex, num_edge} = {1000, 1000}, Graph {num_vertex, num_edge} = {1000, 2000}, Graph {num_vertex, num_edge} = {1000, 999000}, Graph {num_vertex, num_edge} = {5000, 10000}, Graph {num_vertex, num_edge} = {5000, 24995000}, Graph {num_vertex, num_edge} = {5000, 5000}
Estimated total run time: 2.80 min

Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {10, 10} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {10, 20} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {10, 90} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {100, 100} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {100, 200} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {100, 9900} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {1000, 1000} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {1000, 2000} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {1000, 999000} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {5000, 10000} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {5000, 24995000} ...
Benchmarking EtsGraph.get with input Graph {num_vertex, num_edge} = {5000, 5000} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {10, 10} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {10, 20} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {10, 90} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {100, 100} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {100, 200} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {100, 9900} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {1000, 1000} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {1000, 2000} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {1000, 999000} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {5000, 10000} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {5000, 24995000} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {5000, 5000} ...

##### With input Graph {num_vertex, num_edge} = {10, 10} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.80 M      263.22 ns  ±6875.80%         208 ns         333 ns
EtsGraph.put        3.23 M      309.50 ns  ±7289.78%         291 ns         417 ns

Comparison: 
EtsGraph.get        3.80 M
EtsGraph.put        3.23 M - 1.18x slower +46.28 ns

##### With input Graph {num_vertex, num_edge} = {10, 20} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.80 M      263.27 ns  ±9314.22%         209 ns         334 ns
EtsGraph.put        3.17 M      315.60 ns  ±7245.80%         291 ns         417 ns

Comparison: 
EtsGraph.get        3.80 M
EtsGraph.put        3.17 M - 1.20x slower +52.33 ns

##### With input Graph {num_vertex, num_edge} = {10, 90} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.69 M      270.96 ns  ±8590.21%         209 ns         333 ns
EtsGraph.put        3.08 M      324.79 ns  ±7095.67%         292 ns         417 ns

Comparison: 
EtsGraph.get        3.69 M
EtsGraph.put        3.08 M - 1.20x slower +53.83 ns

##### With input Graph {num_vertex, num_edge} = {100, 100} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.64 M      274.76 ns  ±8197.40%         209 ns         333 ns
EtsGraph.put        2.76 M      362.55 ns  ±4963.25%         333 ns         500 ns

Comparison: 
EtsGraph.get        3.64 M
EtsGraph.put        2.76 M - 1.32x slower +87.79 ns

##### With input Graph {num_vertex, num_edge} = {100, 200} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.64 M      274.54 ns  ±7411.32%         250 ns         334 ns
EtsGraph.put        2.61 M      382.66 ns  ±4916.99%         334 ns         541 ns

Comparison: 
EtsGraph.get        3.64 M
EtsGraph.put        2.61 M - 1.39x slower +108.12 ns

##### With input Graph {num_vertex, num_edge} = {100, 9900} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.44 M      290.87 ns  ±7528.34%         250 ns         375 ns
EtsGraph.put        2.47 M      405.19 ns  ±5147.82%         375 ns         542 ns

Comparison: 
EtsGraph.get        3.44 M
EtsGraph.put        2.47 M - 1.39x slower +114.32 ns

##### With input Graph {num_vertex, num_edge} = {1000, 1000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.67 M      272.81 ns  ±6156.71%         250 ns         334 ns
EtsGraph.put        1.61 M      621.70 ns  ±1615.55%         583 ns        1083 ns

Comparison: 
EtsGraph.get        3.67 M
EtsGraph.put        1.61 M - 2.28x slower +348.90 ns

##### With input Graph {num_vertex, num_edge} = {1000, 2000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.60 M      277.85 ns  ±4413.52%         250 ns         375 ns
EtsGraph.put        1.56 M      640.60 ns  ±1763.92%         583 ns        1125 ns

Comparison: 
EtsGraph.get        3.60 M
EtsGraph.put        1.56 M - 2.31x slower +362.75 ns

##### With input Graph {num_vertex, num_edge} = {1000, 999000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        1.97 M      507.73 ns  ±2888.02%         458 ns         833 ns
EtsGraph.put        1.47 M      680.72 ns  ±2795.66%         625 ns        1042 ns

Comparison: 
EtsGraph.get        1.97 M
EtsGraph.put        1.47 M - 1.34x slower +173.00 ns

##### With input Graph {num_vertex, num_edge} = {5000, 10000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.52 M        0.28 μs  ±5377.75%        0.25 μs        0.38 μs
EtsGraph.put        0.96 M        1.04 μs   ±943.51%           1 μs        1.71 μs

Comparison: 
EtsGraph.get        3.52 M
EtsGraph.put        0.96 M - 3.68x slower +0.76 μs

##### With input Graph {num_vertex, num_edge} = {5000, 24995000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        1.65 M      604.38 ns  ±2433.01%         500 ns         958 ns
EtsGraph.put        1.26 M      796.30 ns  ±2518.92%         708 ns        1208 ns

Comparison: 
EtsGraph.get        1.65 M
EtsGraph.put        1.26 M - 1.32x slower +191.92 ns

##### With input Graph {num_vertex, num_edge} = {5000, 5000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.48 M        0.29 μs  ±6289.53%        0.25 μs        0.38 μs
EtsGraph.put        0.95 M        1.05 μs   ±938.52%           1 μs        1.71 μs

Comparison: 
EtsGraph.get        3.48 M
EtsGraph.put        0.95 M - 3.67x slower +0.77 μs
```

1. The maximum number of edges when the number of vertexes is 5,000 is 24,995,000. 
2. The average execution time of `EtsGraph.put` in this case is 796.30 ns.
3. Then, total execution time of `EtsGraph.put` when generating the graph in this case is 19,904 msec.
4. Total execution time of generating the graph in this case is 21,322.16 msec. It is 1.07 times faster than that of `MapGraph`. 
5. About 93% is the ratio of generating the graph to `EtsGraph.put`, and about 7% is some overheads. This is 2.4 times less than that of `MapGraph`.


### MnesiaGraph and Benchmark of it

`VariousMap.MnesiaGraph` is a module for a global graph that can use for a directed graph using Mnesia.


Run `mix run -r bench/mnesia_graph_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/mnesia_graph_bench.exs
time of create random_edges: 0.65msec.
time of create random_edges: 2.954msec.
time of create random_edges: 612.574msec.
time of create random_edges: 24972.64msec.
time of create MnesiaGraph: 4.301msec
time of create MnesiaGraph: 1.969msec
time of create MnesiaGraph: 2.784msec
time of create MnesiaGraph: 2.441msec
time of create MnesiaGraph: 3.853msec
time of create MnesiaGraph: 139.017msec
time of create MnesiaGraph: 15.735msec
time of create MnesiaGraph: 29.552msec
time of create MnesiaGraph: 18311.401msec
time of create MnesiaGraph: 91.298msec
time of create MnesiaGraph: 180.053msec
time of create MnesiaGraph: 532464.164msec
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 24 GB
Elixir 1.14.0
Erlang 25.0.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: Graph {num_vertex, num_edge} = {10, 10}, Graph {num_vertex, num_edge} = {10, 20}, Graph {num_vertex, num_edge} = {10, 90}, Graph {num_vertex, num_edge} = {100, 100}, Graph {num_vertex, num_edge} = {100, 200}, Graph {num_vertex, num_edge} = {100, 9900}, Graph {num_vertex, num_edge} = {1000, 1000}, Graph {num_vertex, num_edge} = {1000, 2000}, Graph {num_vertex, num_edge} = {1000, 999000}, Graph {num_vertex, num_edge} = {5000, 10000}, Graph {num_vertex, num_edge} = {5000, 24995000}, Graph {num_vertex, num_edge} = {5000, 5000}
Estimated total run time: 2.80 min

Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {10, 10} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {10, 20} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {10, 90} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {100, 100} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {100, 200} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {100, 9900} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {1000, 1000} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {1000, 2000} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {1000, 999000} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {5000, 10000} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {5000, 24995000} ...
Benchmarking MnesiaGraph.get with input Graph {num_vertex, num_edge} = {5000, 5000} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {10, 10} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {10, 20} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {10, 90} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {100, 100} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {100, 200} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {100, 9900} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {1000, 1000} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {1000, 2000} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {1000, 999000} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {5000, 10000} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {5000, 24995000} ...
Benchmarking MnesiaGraph.put with input Graph {num_vertex, num_edge} = {5000, 5000} ...

##### With input Graph {num_vertex, num_edge} = {10, 10} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.put       54.56 K       18.33 μs    ±16.47%       17.88 μs       26.33 μs
MnesiaGraph.get       53.58 K       18.66 μs    ±25.68%       18.21 μs       27.42 μs

Comparison: 
MnesiaGraph.put       54.56 K
MnesiaGraph.get       53.58 K - 1.02x slower +0.34 μs

##### With input Graph {num_vertex, num_edge} = {10, 20} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       54.80 K       18.25 μs    ±26.60%       17.83 μs       27.63 μs
MnesiaGraph.put       54.76 K       18.26 μs    ±17.20%       17.83 μs       26.25 μs

Comparison: 
MnesiaGraph.get       54.80 K
MnesiaGraph.put       54.76 K - 1.00x slower +0.0149 μs

##### With input Graph {num_vertex, num_edge} = {10, 90} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       54.47 K       18.36 μs    ±26.11%       17.96 μs          27 μs
MnesiaGraph.put       54.43 K       18.37 μs    ±16.01%       17.92 μs       26.25 μs

Comparison: 
MnesiaGraph.get       54.47 K
MnesiaGraph.put       54.43 K - 1.00x slower +0.0117 μs

##### With input Graph {num_vertex, num_edge} = {100, 100} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.put       53.80 K       18.59 μs    ±24.04%       18.13 μs       26.83 μs
MnesiaGraph.get       46.86 K       21.34 μs    ±54.82%       17.29 μs       64.17 μs

Comparison: 
MnesiaGraph.put       53.80 K
MnesiaGraph.get       46.86 K - 1.15x slower +2.75 μs

##### With input Graph {num_vertex, num_edge} = {100, 200} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       57.85 K       17.29 μs    ±79.87%       16.63 μs       26.13 μs
MnesiaGraph.put       54.30 K       18.42 μs    ±16.74%          18 μs       26.46 μs

Comparison: 
MnesiaGraph.get       57.85 K
MnesiaGraph.put       54.30 K - 1.07x slower +1.13 μs

##### With input Graph {num_vertex, num_edge} = {100, 9900} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       58.99 K       16.95 μs    ±30.83%       16.42 μs       24.54 μs
MnesiaGraph.put       54.71 K       18.28 μs    ±16.94%       17.79 μs       26.50 μs

Comparison: 
MnesiaGraph.get       58.99 K
MnesiaGraph.put       54.71 K - 1.08x slower +1.33 μs

##### With input Graph {num_vertex, num_edge} = {1000, 1000} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.put       53.75 K       18.60 μs    ±25.63%       18.08 μs       27.17 μs
MnesiaGraph.get       53.53 K       18.68 μs  ±1544.73%       16.38 μs       31.13 μs

Comparison: 
MnesiaGraph.put       53.75 K
MnesiaGraph.get       53.53 K - 1.00x slower +0.0763 μs

##### With input Graph {num_vertex, num_edge} = {1000, 2000} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       60.40 K       16.56 μs    ±30.60%       16.04 μs       24.08 μs
MnesiaGraph.put       53.82 K       18.58 μs    ±16.45%       18.08 μs       26.92 μs

Comparison: 
MnesiaGraph.get       60.40 K
MnesiaGraph.put       53.82 K - 1.12x slower +2.02 μs

##### With input Graph {num_vertex, num_edge} = {1000, 999000} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       59.03 K       16.94 μs    ±30.41%       16.42 μs       24.58 μs
MnesiaGraph.put       45.05 K       22.20 μs   ±274.81%       18.54 μs       73.96 μs

Comparison: 
MnesiaGraph.get       59.03 K
MnesiaGraph.put       45.05 K - 1.31x slower +5.25 μs

##### With input Graph {num_vertex, num_edge} = {5000, 10000} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       60.20 K       16.61 μs    ±19.91%       16.21 μs       23.79 μs
MnesiaGraph.put       54.23 K       18.44 μs    ±26.21%       17.96 μs       26.50 μs

Comparison: 
MnesiaGraph.get       60.20 K
MnesiaGraph.put       54.23 K - 1.11x slower +1.83 μs

##### With input Graph {num_vertex, num_edge} = {5000, 24995000} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       56.05 K       17.84 μs    ±35.85%       17.13 μs       26.79 μs
MnesiaGraph.put       53.50 K       18.69 μs    ±48.00%       18.04 μs       27.63 μs

Comparison: 
MnesiaGraph.get       56.05 K
MnesiaGraph.put       53.50 K - 1.05x slower +0.85 μs

##### With input Graph {num_vertex, num_edge} = {5000, 5000} #####
Name                      ips        average  deviation         median         99th %
MnesiaGraph.get       58.86 K       16.99 μs    ±25.95%       16.46 μs       24.75 μs
MnesiaGraph.put       53.76 K       18.60 μs    ±24.24%       18.13 μs       26.79 μs

Comparison: 
MnesiaGraph.get       58.86 K
MnesiaGraph.put       53.76 K - 1.09x slower +1.61 μs
```

1. The maximum number of edges when the number of vertexes is 5,000 is 24,995,000. 
2. The average execution time of `MnesiaGraph.put` in this case is 18.69 μs.
3. Then, total execution time of `MnesiaGraph.put` when generating the graph in this case is 467,156.55 msec.
4. Total execution time of generating the graph in this case is 532,464.164 msec. It is and 23.3 and 25.0 times slower than that of `MapGraph` and `EtsGraph`, respectively. 
5. About 88% is the ratio of generating the graph to `MnesiaGraph.put`, and about 12% is some overheads. This is 1.4 times less than that of `MapGraph`, and is 1.7 times more than that of `EtsGraph`.

## License

Copyright (c) 2022 University of Kitakyushu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
