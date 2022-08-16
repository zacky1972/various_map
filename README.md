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

## MapGraph and Benchmark of it

`VariousMap.MapGraph` is a module for a graph that can use for both a directed and a undirected graph using `Map`.


Run `mix run -r bench/map_graph_bench.exs`, then you'll get results similar to the following:

```
% mix run -r bench/map_graph_bench.exs
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
inputs: Graph {num_vertex, num_edge} = {10, 10}, Graph {num_vertex, num_edge} = {10, 20}, Graph {num_vertex, num_edge} = {10, 90}, Graph {num_vertex, num_edge} = {100, 100}, Graph {num_vertex, num_edge} = {100, 200}, Graph {num_vertex, num_edge} = {100, 9900}, Graph {num_vertex, num_edge} = {1000, 1000}, Graph {num_vertex, num_edge} = {1000, 2000}, Graph {num_vertex, num_edge} = {1000, 999000}
Estimated total run time: 2.10 min

Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {10, 10} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {10, 20} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {10, 90} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {100, 100} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {100, 200} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {100, 9900} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {1000, 1000} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {1000, 2000} ...
Benchmarking MapGraph.get with input Graph {num_vertex, num_edge} = {1000, 999000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {10, 10} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {10, 20} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {10, 90} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {100, 100} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {100, 200} ...
...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {1000, 1000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {1000, 2000} ...
Benchmarking MapGraph.put with input Graph {num_vertex, num_edge} = {1000, 999000} ...

##### With input Graph {num_vertex, num_edge} = {10, 10} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.69 M      213.36 ns ±17504.20%         166 ns         208 ns
MapGraph.put        3.54 M      282.82 ns  ±9489.69%         209 ns         458 ns

Comparison: 
MapGraph.get        4.69 M
MapGraph.put        3.54 M - 1.33x slower +69.46 ns

##### With input Graph {num_vertex, num_edge} = {10, 20} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.65 M      215.15 ns ±17295.97%         166 ns         208 ns
MapGraph.put        3.19 M      313.36 ns ±11864.01%         250 ns         417 ns

Comparison: 
MapGraph.get        4.65 M
MapGraph.put        3.19 M - 1.46x slower +98.21 ns

##### With input Graph {num_vertex, num_edge} = {10, 90} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.57 M      218.86 ns ±15099.28%         167 ns         209 ns
MapGraph.put        2.94 M      339.90 ns  ±9856.49%         250 ns         458 ns

Comparison: 
MapGraph.get        4.57 M
MapGraph.put        2.94 M - 1.55x slower +121.04 ns

##### With input Graph {num_vertex, num_edge} = {100, 100} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.48 M      223.37 ns ±10550.96%         167 ns         250 ns
MapGraph.put        2.62 M      381.93 ns  ±4544.48%         292 ns         500 ns

Comparison: 
MapGraph.get        4.48 M
MapGraph.put        2.62 M - 1.71x slower +158.56 ns

##### With input Graph {num_vertex, num_edge} = {100, 200} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        4.06 M      246.37 ns ±12658.92%         167 ns         250 ns
MapGraph.put        2.48 M      402.82 ns  ±7154.28%         333 ns         584 ns

Comparison: 
MapGraph.get        4.06 M
MapGraph.put        2.48 M - 1.64x slower +156.45 ns

##### With input Graph {num_vertex, num_edge} = {100, 9900} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        3.37 M      296.70 ns ±13766.84%         209 ns         334 ns
MapGraph.put        2.42 M      413.59 ns  ±3309.08%         375 ns         583 ns

Comparison: 
MapGraph.get        3.37 M
MapGraph.put        2.42 M - 1.39x slower +116.90 ns

##### With input Graph {num_vertex, num_edge} = {1000, 1000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        3.72 M      268.89 ns ±14565.16%         208 ns         291 ns
MapGraph.put        2.41 M      415.65 ns  ±6649.29%         375 ns         583 ns

Comparison: 
MapGraph.get        3.72 M
MapGraph.put        2.41 M - 1.55x slower +146.76 ns

##### With input Graph {num_vertex, num_edge} = {1000, 2000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        3.75 M      266.67 ns ±11280.61%         208 ns         292 ns
MapGraph.put        2.36 M      424.20 ns  ±5360.74%         375 ns         584 ns

Comparison: 
MapGraph.get        3.75 M
MapGraph.put        2.36 M - 1.59x slower +157.53 ns

##### With input Graph {num_vertex, num_edge} = {1000, 999000} #####
Name                   ips        average  deviation         median         99th %
MapGraph.get        1.69 M      593.16 ns  ±3253.38%         541 ns        1042 ns
MapGraph.put        1.34 M      744.81 ns  ±1271.50%         667 ns        1167 ns

Comparison: 
MapGraph.get        1.69 M
MapGraph.put        1.34 M - 1.26x slower +151.65 ns
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
