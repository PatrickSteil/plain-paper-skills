# Presenting experiments and data

Contents: Before writing, Order, Setup, Measurement hygiene, Instances, Data artifacts, Query protocol, Metrics, Verification, Baselines, Parameter studies, Ablation, Stratified queries, Parallel results, Prose, Tables and figures, Numbers, Reproducibility, Honesty rules.

Never invent measurements. If a number is missing, write `[TODO: ...]` (in LaTeX: `\TODO{...}`).

## Before writing

Experiments are designed before they are written up. Sanders describes the process: explore with a flexible measurement tool, form hypotheses, then run focused measurements that test them. Before the section is written, check:

- Which question does each experiment answer? An experiment without a question goes to the appendix or is dropped.
- What is the biggest risk to the conclusion? Usually a strong baseline or an instance class that was not tried. Close that gap before writing, or name it as a limitation.
- Which parameters are varied, which are fixed, and why the fixed values were chosen.
- Can the setup be redesigned to be more concise or more accurate now that the interesting ranges are known?

## Order of the Experiments section

1. Setup (hardware, software, measurement procedure).
2. Instances (table), including known data defects.
3. Query protocol.
4. Parameter study for tuning parameters, with the chosen values.
5. Preprocessing results (if any).
6. Ablation of the paper's own components.
7. Comparison with other algorithms, including verification of results.
8. Stratified or scaling results (local versus long-range queries, number of cores, instance size).
9. Additional instances to show consistency.
10. One closing paragraph: the main finding and its limit.

## Setup

One paragraph. Give:

- CPU model, number of sockets and cores, clock speed.
- RAM size and type, and cache size if the algorithm is cache sensitive.
- Language, compiler with version, optimization flags, parallelization library.
- Number of threads used and whether threads are pinned.
- Operating system only if it matters.

## Measurement hygiene

State what was done; do it before measuring.

- Warm-up runs before timing; data loaded and preprocessed before the clock starts, unless loading is what is measured.
- Fixed CPU frequency or a note that turbo boost was on; threads pinned; no other load on the machine.
- Repeat measurements. Report the median of repetitions for deterministic code, and the number of repetitions.
- Same compiler, flags, and machine for all algorithms that are compared directly.
- Timing granularity matches the measured times. Sub-microsecond operations are timed in batches.
- Memory measured the same way for all algorithms (data structure size, or peak resident memory; say which).

## Instances

- Put all instances in one table: name, size parameters (vertices, edges, stops, trips, connections), and any derived quantity the algorithm depends on.
- Describe the source of each instance (public data, date, which modes are included).
- State what was added or generated and why: "No footpath data was available for these networks, so we generated synthetic footpaths with a known heuristic."
- State if an instance is smaller than the main one.

## Data artifacts

Real inputs have defects (isolated stops, duplicate locations, missing footpaths). They can produce effects that look like algorithmic behavior.

- If a result is unexpected, check whether the input causes it before explaining it with the algorithm.
- Separate the two effects in the evaluation. ULTRA found that stops isolated from the transfer graph caused many and disproportionately long shortcuts, and reported the numbers with and without them.
- State the defects you know of in the instances paragraph, with counts ("625 stops are not connected to the transfer graph").
- Do not silently clean the data. Say what was removed or contracted and why.

## Query protocol

- Say how queries are drawn: "10 000 queries with source, target, and departure time chosen uniformly at random."
- Report averages and say so. Report medians or percentiles if the distribution is skewed.
- Say what is excluded: "We do not compute full journey descriptions."
- Say whether other distributions were tested, and only claim "similar" if they were.

## Metrics

Report running time and at least one machine-independent count.

- Running time in the same unit throughout (ms, or s for preprocessing).
- Machine-independent counts: rounds, relaxed routes or edges per vertex, vertex visits, label comparisons per stop, size of the output set.
- Preprocessing: time (sequential and parallel), space, and what is stored.
- For parallel algorithms: work and time on 1, p, and the maximum number of threads, and self-relative speedup.

Machine-independent counts let the reader compare with results from other hardware. Normalize them (per stop, per vertex) so instances are comparable.

## Verification

Exactness is a claim; check it.

- Compare the output of the new algorithm with a simple reference (Dijkstra, a naive implementation, an existing exact algorithm) on all evaluation queries, or on a stated subset. Report it in one sentence: "On all 10 000 queries, X returned the same Pareto sets as Y."
- Compare result values, not only sizes. For Pareto sets, compare the sets of (arrival time, trips) pairs.
- If the algorithm is heuristic, or a known issue makes it answer some queries wrongly, measure the error: share of queries with a wrong answer, and how wrong (missing journeys, extra delay). Report it per instance. Arc-Flag TB reports its share of incorrect answers per network and the cause.
- If a baseline turns out to be incorrect on some queries, report that with the same measurement, and keep its running times in the comparison with a mark.

## Baselines

- Compare against the strongest relevant prior algorithms.
- Give every baseline the same optimizations as the new algorithm. State which optimizations each one uses ("RAPTOR uses marking, local, and target pruning; MLC uses pruning, label forwarding, and hop avoidance").
- If numbers are taken from the literature, say so in the caption and cite the source. Note differences in hardware and instances.
- If a direct comparison is not possible, say why in one sentence: "Direct comparison with X is difficult, since it does not support bicriteria queries."
- When a baseline solves a simpler problem, include it as a reference and mark it in the table.
- Use marker columns in the table to show which problem each row solves (a filled symbol for "minimizes transfers", an empty one for "does not").
- State where a competitor wins. Give the cost of the new algorithm's advantage ("faster query times at the cost of a few minutes of preprocessing").

## Parameter studies

Every tuning parameter needs a justified value.

- Vary each parameter over a range on one representative instance and plot its effect on all costs it influences (preprocessing time, space, query time, output size). ULTRA does this for the core degree and the witness limit.
- Mark the chosen value and say why ("lowest total preprocessing time"; "the number of shortcuts changes by fewer than 600 over the full range, so we chose 15 minutes").
- If the value is chosen differently for a larger instance, say why ("the share of contraction time decreases with network size").
- If a parameter trades one cost for another, show the tradeoff curve instead of one configuration.
- A parameter that has little effect is a result too. Say so.

## Ablation

- Measure each engineering choice separately on one instance: basic, with each optimization, all optimizations, all optimizations except the main component.
- Give the factor for each: "With all optimizations, profile queries are 2 times faster. Transfer reduction makes them 3 times faster."
- Include the variant without the main preprocessing step to show its effect.

## Stratified queries

- Show that average-case results do not hide a problem. Use a rank-based query set (geographic rank or Dijkstra rank): pick a source, order all vertices by distance, query to the 2^r-th one.
- Plot running time against rank on a logarithmic scale for both axes if the range is wide.
- Say in the text what the plot shows: local queries are an order of magnitude faster, and there are outliers (and why).

## Parallel results

- Give the numbers for 1, several, and the maximum number of cores.
- If speedups are small, say so and give the cause: "The parallel part is 75% of the sequential running time, so Amdahl's law limits the speedup."
- State the overhead of the parallel version on one core (percent slowdown).
- Say where extra cores stop paying off and give a likely reason (memory contention), marked as a reason, not a fact, unless measured.

## Prose

- One paragraph of prose per table or figure. Interpret it. Do not restate the numbers row by row.
- Start from the observation: "We observe that, on average, RAPTOR needs 8.4 rounds and scans each route 3 times."
- State ratios with both quantities when useful: "With 7.3 ms, it is 9 times faster than MLC and 6 times faster than LD."
- Explain the cause of the main result in one or two sentences (simpler data structures, better locality, no priority queue).
- Report negative and weak results with their cause. Write "Parallelization gives a speedup below 1.7 on six cores" and the reason.
- For additional instances, state whether results are consistent with the main instance, and give the numbers.
- Do not use "significantly", "much", "substantially" without a statistical test or a ratio.

## Tables and figures

For building plots and tables, use the paper-figures skill. In short:

- Captions are self-contained: instance, what is measured, what the symbols mean, where numbers come from.
- Put the proposed algorithm in a fixed position and keep row order stable across tables and figures.
- Use the same algorithm names and column names as in the text.
- Give units in column headers and axis labels.
- Align decimals. Use the same precision per column.
- One color, marker, and dash pattern per algorithm for the whole paper, from the palette.
- When two numbers were measured on different query sets or machines, say so next to the comparison: "Note that comparing RAPTOR and ULTRA-RAPTOR must be done with caution, as they were measured for a different set of queries."

## Numbers

- Use a thin space or a consistent separator for thousands (10 000, 5 132 672).
- Write "a factor of 9" or "9 times faster". Do not write "900% faster".
- Use "about" only with a stated rounding.
- Give percentages with their base ("eliminates 84% of transfers on London").
- Keep significant digits consistent with the measurement precision.

## Reproducibility

- Link the source code and the scripts that produce every table and figure, or say why it cannot be released.
- Name the data sources with dates or versions (GTFS feed and date range, OpenStreetMap extract and date).
- Give every parameter value that is not the default described in the text.
- Keep the raw measurement files. Every number in the paper should be traceable to a file and a script.

## Honesty rules

- Report what was measured, on which instances, with which settings.
- State data limitations (synthetic data, missing attributes, smaller instances).
- State when a result did not match the expectation and what is known about the reason.
- Mark untested claims as conjectures.
- Keep the baseline that wins somewhere, and the instance where you lose. See `framing.md`.
- Report "up to X" only together with the range.
- End the section with the main finding and its limit. Do not repeat the tables.
