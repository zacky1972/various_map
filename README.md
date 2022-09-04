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
2. The average execution time of `MapGraph.put` in this case is 1.06 μs.
3. Then, total execution time of `MapGraph.put` when generating the graph in this case is 26,496.7 msec.
4. But, total execution time of generating the graph in this case is 41,416.62 msec.
5. About 64% is the ratio of generating the graph to `MapGraph.put`, and about 36% is some overheads. What does the overheads arise from?

### EtsGraph and Benchmark of it

`VariousMap.EtsGraph` is a module for a global graph that can use for a directed graph using ETS.


Run `mix run -r bench/ets_graph_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/ets_graph_bench.exs
Compiling 1 file (.ex)
time of create random_edges: 0.597msec.
time of create random_edges: 2.706msec.
time of create random_edges: 570.753msec.
time of create random_edges: 28044.329msec.
time of create EtsGraph: 0.028msec
time of create EtsGraph: 0.01msec
time of create EtsGraph: 0.028msec
time of create EtsGraph: 0.024msec
time of create EtsGraph: 0.051msec
time of create EtsGraph: 2.819msec
time of create EtsGraph: 0.262msec
time of create EtsGraph: 0.532msec
time of create EtsGraph: 469.701msec
time of create EtsGraph: 2.299msec
time of create EtsGraph: 3.591msec
time of create EtsGraph: 22082.453msec
Operating System: macOS
CPU Information: Apple M1
Number of Available Cores: 8
Available memory: 16 GB
Elixir 1.14.0-rc.1
Erlang 25.0.3

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
{10, 20}, Graph {num_vertex, num_edge} = {10, 90}, Graph {num_vertex, num_edge} = {100, 100}, Graph {num_vertex, num_edge} = {100, 200}, Graph {num_vertex, num_edge} = {100, 9900}, Graph {num_vertex, num_edge} = {1000, 1000}, Graph {num_vertex, num_edge} = {1000, 2000}, Graph {num_vertex, num_edge} = {1000, 999000}, Graph {num_vertex, num_edge} = {5000, 10000}, Graph {num_vertex, num_edge} = {5000, 24995000}, Graph {num_vertex, num_edge} = {5000, 5000}
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
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {5000, 24995000}} ...
Benchmarking EtsGraph.put with input Graph {num_vertex, num_edge} = {5000, 5000} ...

##### With input Graph {num_vertex, num_edge} = {10, 10} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.69 M      270.91 ns  ±9016.00%         209 ns         333 ns
EtsGraph.put        3.25 M      307.91 ns  ±8365.53%         250 ns         375 ns

Comparison: 
EtsGraph.get        3.69 M
EtsGraph.put        3.25 M - 1.14x slower +37.00 ns

Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.74 M      267.05 ns  ±8233.34%         209 ns         333 ns
EtsGraph.put        3.27 M      305.47 ns  ±7981.60%         250 ns         375 ns

Comparison: 
EtsGraph.get        3.74 M
EtsGraph.put        3.27 M - 1.14x slower +38.41 ns

##### With input Graph {num_vertex, num_edge} = {10, 90} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.66 M      273.10 ns  ±8626.86%         250 ns         333 ns
EtsGraph.put        3.28 M      305.34 ns  ±8001.07%         250 ns         375 ns

Comparison: 
EtsGraph.get        3.66 M
EtsGraph.put        3.28 M - 1.12x slower +32.25 ns

##### With input Graph {num_vertex, num_edge} = {100, 100} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.63 M      275.17 ns  ±7182.81%         250 ns         333 ns
EtsGraph.put        3.04 M      329.13 ns  ±7611.84%         292 ns         417 ns

Comparison: 
EtsGraph.get        3.63 M
EtsGraph.put        3.04 M - 1.20x slower +53.96 ns

##### With input Graph {num_vertex, num_edge} = {100, 200} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.55 M      282.05 ns  ±8065.72%         250 ns         333 ns
EtsGraph.put        3.03 M      329.98 ns  ±7615.81%         292 ns         417 ns

Comparison: 
EtsGraph.get        3.55 M
EtsGraph.put        3.03 M - 1.17x slower +47.93 ns

##### With input Graph {num_vertex, num_edge} = {100, 9900} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.28 M      304.52 ns  ±7962.37%         250 ns         416 ns
EtsGraph.put        3.01 M      332.26 ns  ±7580.30%         292 ns         417 ns

Comparison: 
EtsGraph.get        3.28 M
EtsGraph.put        3.01 M - 1.09x slower +27.74 ns

##### With input Graph {num_vertex, num_edge} = {1000, 1000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.49 M      286.93 ns  ±7817.37%         250 ns         375 ns
EtsGraph.put        1.72 M      580.50 ns  ±2036.82%         500 ns        1000 ns

Comparison: 
EtsGraph.get        3.49 M
EtsGraph.put        1.72 M - 2.02x slower +293.56 ns

##### With input Graph {num_vertex, num_edge} = {1000, 2000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.52 M      284.40 ns  ±7002.84%         250 ns         334 ns
EtsGraph.put        1.72 M      582.04 ns  ±2035.18%         500 ns        1000 ns

Comparison: 
EtsGraph.get        3.52 M
EtsGraph.put        1.72 M - 2.05x slower +297.64 ns

##### With input Graph {num_vertex, num_edge} = {1000, 999000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        1.80 M      555.79 ns  ±3066.80%         459 ns         916 ns
EtsGraph.put        1.65 M      607.47 ns  ±3147.06%         500 ns         958 ns

Comparison: 
EtsGraph.get        1.80 M
EtsGraph.put        1.65 M - 1.09x slower +51.68 ns

##### With input Graph {num_vertex, num_edge} = {5000, 10000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.38 M      296.05 ns  ±6770.76%         250 ns         416 ns
EtsGraph.put        1.19 M      837.77 ns  ±1673.47%         791 ns        1458 ns

Comparison: 
EtsGraph.get        3.38 M
EtsGraph.put        1.19 M - 2.83x slower +541.72 ns

##### With input Graph {num_vertex, num_edge} = {5000, 24995000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        1.55 M      646.50 ns  ±2911.51%         583 ns        1083 ns
EtsGraph.put        1.43 M      697.43 ns  ±3176.21%         584 ns        1125 ns

Comparison: 
EtsGraph.get        1.55 M
EtsGraph.put        1.43 M - 1.08x slower +50.94 ns

##### With input Graph {num_vertex, num_edge} = {5000, 5000} #####
Name                   ips        average  deviation         median         99th %
EtsGraph.get        3.42 M      292.42 ns  ±6591.03%         250 ns         375 ns
EtsGraph.put        1.16 M      864.43 ns  ±1659.11%         792 ns        1500 ns

Comparison: 
EtsGraph.get        3.42 M
EtsGraph.put        1.16 M - 2.96x slower +572.01 ns
```

1. The maximum number of edges when the number of vertexes is 5,000 is 24,995,000. 
2. The average execution time of `EtsGraph.put` in this case is 697.43 ns.
3. Then, total execution time of `EtsGraph.put` when generating the graph in this case is 17,432 msec.
4. Total execution time of generating the graph in this case is 22,082.453 msec. It is 1.88 times faster than that of `MapGraph`. 
5. About 79% is the ratio of generating the graph to `EtsGraph.put`, and about 21% is some overheads. This is 1.7 times less than that of `MapGraph`.

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
