# Tables

Contents: When to use a table, Layout, Content, Captions, Instance table, Bounds table, Template.

## When to use a table

- About 20 numbers or fewer, or values the reader needs exactly (to reproduce or compare across papers). (Sanders, following Tufte.)
- Results per instance where instances have no natural order on an axis.
- Several metrics per algorithm (times per phase plus machine-independent counts).
- Larger tables go to an appendix or a supplementary file. The main text keeps the small table that supports the claims.

If a table has a numeric parameter in its rows (sizes, cores, ranks) and more than a handful of rows, it is probably a plot.

## Layout

- `booktabs` rules only: `\toprule`, `\midrule`, `\bottomrule`, `\cmidrule` for column groups. No vertical lines. No double lines.
- `siunitx` `S` columns align decimals. Set `table-format` per column. Same precision within a column.
- Units in the header in brackets: `Time [ms]`. Group related columns under a spanning header ("Scans [k]", "Time [ms]").
- Thousands separated by a thin space (`\num{10000}` gives 10 000).
- Caption above the table.
- Rows: put the proposed algorithm in the same position in every table (first or last of each block). Keep row order stable across tables and figures.
- Do not bold the "winner". It invites the reader to count wins instead of reading the tradeoff. If highlighting is needed, explain it in the caption.
- Blocks per instance separated by `\midrule`, with the instance name in a first column or as a block header.

## Content

- Next to every running time, give at least one machine-independent count (scanned routes, relaxed edges, settled vertices, label comparisons). It lets readers compare with other hardware.
- Split time into phases if the algorithm has phases. It shows where the gain comes from.
- **Marker columns** for capabilities: which problem each row solves (full graph or restricted, minimizes transfers or not, exact or heuristic). Use $\bullet$ for yes and $\circ$ for no, as in RAPTOR, CSA, and ULTRA tables. A row that solves an easier problem gets a mark ($^*$) and a sentence in the caption.
- Numbers from the literature are marked and cited in the caption, with the hardware difference stated. Scale them only if you say how.
- A missing value is "—" with the reason in the caption ("does not support profile queries"), never an empty cell.

## Captions

The caption states: instance, query set (how many, how drawn), what each column means if not obvious, what the markers mean, what is averaged (mean or median), and where external numbers come from. Example: the caption says that RAPTOR (marked) only supports stop-to-stop queries with transitive transfers, while the other rows support vertex-to-vertex queries on the full graph.

The text then interprets the table in one paragraph (see the algorithm-paper-writing skill, experiments). It does not repeat the rows.

## Instance table

One table at the start of the experiments: one row per instance; columns for the size parameters the algorithm depends on (stops, routes, trips, stop events, vertices, edges); a column for derived graphs if they matter (full versus transitively closed edges). Source and date of each instance go in the text.

## Bounds table

For theory-heavy papers: one row per problem; columns for the section, the bound (work and span, or time and space), and the bound type (worst case, expected, whp), with a column or mark for prior best bounds in the same model.

## Template

`assets/tables/query-table.tex` is a results table with marker columns, grouped headers, phase times, and a self-contained caption. It uses `assets/latex/paper-macros.tex` (booktabs, siunitx with thin-space grouping, `\algname`, `\TODO`). Its numbers are synthetic placeholders.
