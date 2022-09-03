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

Map is 12.1-18.2x and 77.4-119x faster than EtsMap and MnesiaMap, respectively.

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

EtsMap is 12.1-18.2x slower than Map.
EtsMap is 6.40-6.51x faster than MnesiaMap.

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

MnesiaMap is 77.4-119x and 6.40-6.51x slower than Map and EtsMap, respectively.


### MapGraph and Benchmark of it

`VariousMap.MapGraph` is a module for a graph that can use for both a directed and a undirected graph using `Map`.


Run `mix run -r bench/map_graph_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/map_graph_bench.exs
time of create random_edges: 0.713msec.
time of create random_edges: 4.481msec.
time of create random_edges: 875.896msec.
time of create random_edges: 33377.593msec.
time of create MapGraph: 0.015msec
time of create MapGraph: 0.002msec
time of create MapGraph: 0.024msec
time of create MapGraph: 0.043msec
time of create MapGraph: 0.045msec
time of create MapGraph: 3.501msec
time of create MapGraph: 0.267msec
time of create MapGraph: 0.58msec
time of create MapGraph: 1186.544msec
time of create MapGraph: 2.459msec
time of create MapGraph: 4.098msec
time of create MapGraph: 41416.62msec
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
000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {5000, 5000} ...

##### With input Graph {num_vertex, num_edge} = {10, 10} #####
Name                   ips        average  deviation         median         99th %
MapGraph.put        3.17 M      315.56 ns ±13718.13%         209 ns         458 ns
MapGraph.get        2.81 M      356.22 ns ±67762.37%         125 ns         209 ns

Comparison: 
MapGraph.put        3.17 M
MapGraph.get        2.81 M - 1.13x slower +40.67 ns

Name                   ips        average  deviation         median         99th %
MapGraph.put        2.10 M      476.66 ns ±30115.64%         209 ns         459 ns
MapGraph.get        1.98 M      505.90 ns ±45785.93%         166 ns         333 ns

Comparison: 
MapGraph.put        2.10 M
MapGraph.get        1.98 M - 1.06x slower +29.23 ns

##### With input Graph {num_vertex, num_edge} = {10, 90} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.18 M      239.30 ns ±61742.01%         166 ns         209 ns
MapGraph.put        1.94 M      514.48 ns ±27373.87%         250 ns         500 ns

Comparison: 
MapGraph.get        4.18 M
MapGraph.put        1.94 M - 2.15x slower +275.17 ns

##### With input Graph {num_vertex, num_edge} = {100, 100} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        2.35 M      425.52 ns ±57255.76%         167 ns         250 ns
MapGraph.put        2.07 M      483.08 ns ±18686.34%         292 ns         500 ns

Comparison: 
MapGraph.get        2.35 M
MapGraph.put        2.07 M - 1.14x slower +57.56 ns

##### With input Graph {num_vertex, num_edge} = {100, 200} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.98 M      200.88 ns ±18824.61%         167 ns         250 ns
MapGraph.put        2.47 M      404.76 ns ±14900.37%         292 ns         542 ns

Comparison: 
MapGraph.get        4.98 M
MapGraph.put        2.47 M - 2.01x slower +203.88 ns

##### With input Graph {num_vertex, num_edge} = {100, 9900} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        3.68 M      271.89 ns ±46822.54%         208 ns         333 ns
MapGraph.put        1.82 M      548.31 ns ±28400.13%         375 ns         583 ns

Comparison: 
MapGraph.get        3.68 M
MapGraph.put        1.82 M - 2.02x slower +276.42 ns

##### With input Graph {num_vertex, num_edge} = {1000, 1000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        5.13 M      195.08 ns    ±77.37%         208 ns         250 ns
MapGraph.put        1.98 M      504.94 ns ±15354.97%         334 ns         583 ns

Comparison: 
MapGraph.get        5.13 M
MapGraph.put        1.98 M - 2.59x slower +309.86 ns

##### With input Graph {num_vertex, num_edge} = {1000, 2000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        3.28 M      304.74 ns ±49168.98%         208 ns         292 ns
MapGraph.put        2.01 M      497.33 ns ±14571.29%         375 ns         583 ns

Comparison: 
MapGraph.get        3.28 M
MapGraph.put        2.01 M - 1.63x slower +192.59 ns

##### With input Graph {num_vertex, num_edge} = {1000, 999000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.put        1.25 M      801.65 ns  ±7891.48%         667 ns        2082 ns
MapGraph.get        1.14 M      875.55 ns ±26599.03%         500 ns        1167 ns

Comparison: 
MapGraph.put        1.25 M
MapGraph.get        1.14 M - 1.09x slower +73.90 ns

##### With input Graph {num_vertex, num_edge} = {5000, 10000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        3.34 M      299.15 ns ±47074.16%         209 ns         375 ns
MapGraph.put        1.77 M      564.49 ns ±26043.86%         416 ns        1916 ns

Comparison: 
MapGraph.get        3.34 M
MapGraph.put        1.77 M - 1.89x slower +265.34 ns

##### With input Graph {num_vertex, num_edge} = {5000, 24995000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.put      944.44 K        1.06 μs  ±5250.09%        0.96 μs        2.38 μs
MapGraph.get      475.36 K        2.10 μs ±49703.62%        1.29 μs        2.75 μs

Comparison: 
MapGraph.put      944.44 K
MapGraph.get      475.36 K - 1.99x slower +1.04 μs

##### With input Graph {num_vertex, num_edge} = {5000, 5000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        3.25 M      307.38 ns ±50333.48%         208 ns         333 ns
MapGraph.put        1.78 M      561.28 ns ±23872.27%         375 ns         667 ns

Comparison: 
MapGraph.get        3.25 M
MapGraph.put        1.78 M - 1.83x slower +253.89 ns
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
