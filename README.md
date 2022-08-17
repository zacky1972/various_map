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
Map get        6.70 M      149.32 ns ±14716.28%         125 ns         125 ns
Map put        5.09 M      196.29 ns ±14034.11%         125 ns         167 ns

Comparison: 
Map get        6.70 M
Map put        5.09 M - 1.31x slower +46.97 ns

##### With input size 100 #####
Name              ips        average  deviation         median         99th %
Map get        5.40 M      185.12 ns ±16586.92%         125 ns         208 ns
Map put        4.87 M      205.28 ns ±18602.38%         125 ns         167 ns

Comparison: 
Map get        5.40 M
Map put        4.87 M - 1.11x slower +20.16 ns

##### With input size 1000 #####
Name              ips        average  deviation         median         99th %
Map get        5.16 M      193.84 ns ±17967.19%         125 ns         209 ns
Map put        5.16 M      193.91 ns ±15937.02%         125 ns         167 ns

Comparison: 
Map get        5.16 M
Map put        5.16 M - 1.00x slower +0.0760 ns

##### With input size 10000 #####
Name              ips        average  deviation         median         99th %
Map put        5.30 M      188.63 ns ±14311.70%         125 ns         208 ns
Map get        4.55 M      219.61 ns ±14863.87%         167 ns         250 ns

Comparison: 
Map put        5.30 M
Map get        4.55 M - 1.16x slower +30.98 ns

##### With input size 100000 #####
Name              ips        average  deviation         median         99th %
Map put        5.23 M      191.33 ns ±15712.50%         125 ns         167 ns
Map get        4.16 M      240.42 ns  ±7451.18%         208 ns         583 ns

Comparison: 
Map put        5.23 M
Map get        4.16 M - 1.26x slower +49.09 ns
```

The operations of `Map.get/3` and `Map.put/3` work in logarithmic time, which means that the time it takes to find keys grows as the map grows, but it's not directly proportional to the map size. 

The results show the growth of the execution time of the operations seems to be very gentle, even considering that they work in logarithmic time.

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

### EtsMap and Benchmark of it

`VariousMap.EtsMap` is a module compatible to `Map` but using ETS.


Run `mix run -r bench/ets_map_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/ets_map_bench.exs  
Compiling 1 file (.ex)
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
ETS Map get      345.20 K        2.90 μs    ±24.79%        2.80 μs        5.22 μs
ETS Map put      335.31 K        2.98 μs    ±27.85%        2.88 μs        5.28 μs

Comparison: 
ETS Map get      345.20 K
ETS Map put      335.31 K - 1.03x slower +0.0854 μs

##### With input size 100 #####
Name                  ips        average  deviation         median         99th %
ETS Map get       10.50 M      0.0952 μs    ±98.08%      0.0840 μs       0.125 μs
ETS Map put      0.0394 M       25.38 μs     ±2.86%       25.18 μs       27.85 μs

Comparison: 
ETS Map get       10.50 M
ETS Map put      0.0394 M - 266.58x slower +25.29 μs

##### With input size 1000 #####
Name                  ips        average  deviation         median         99th %
ETS Map get        2.90 K      344.34 μs     ±1.90%      343.56 μs      363.19 μs
ETS Map put        2.82 K      354.14 μs     ±3.78%      351.93 μs      382.72 μs

Comparison: 
ETS Map get        2.90 K
ETS Map put        2.82 K - 1.03x slower +9.80 μs

##### With input size 10000 #####
Name                  ips        average  deviation         median         99th %
ETS Map put        3.09 M      323.18 ns   ±119.19%         250 ns     3153.70 ns
ETS Map get        2.47 M      405.37 ns   ±172.39%         208 ns     3503.25 ns

Comparison: 
ETS Map put        3.09 M
ETS Map get        2.47 M - 1.25x slower +82.19 ns

##### With input size 100000 #####
Name                  ips        average  deviation         median         99th %
ETS Map put      435.91 K        2.29 μs    ±64.56%        1.83 μs       11.48 μs
ETS Map get      311.11 K        3.21 μs    ±53.78%        2.85 μs       14.58 μs

Comparison: 
ETS Map put      435.91 K
ETS Map get      311.11 K - 1.40x slower +0.92 μs
```

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
