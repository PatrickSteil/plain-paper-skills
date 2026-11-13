---
name: paper-figures
description: "Make plots, diagrams, and results tables for experimental papers in algorithms and systems: standalone pgfplots, gnuplot, and TikZ figures built to PDF with a Makefile; one colorblind-safe palette with a fixed color, marker, and dash per algorithm (Okabe–Ito default, KIT corporate design optional); booktabs and siunitx tables with marker columns; honest axes and self-contained captions. Use for scaling, phase-breakdown, rank, tradeoff, parallel-speedup, and histogram plots, example-instance diagrams, instance and results tables, chart colors, captions, or reviewing a figure or table. For the paper's prose, use the algorithm-paper-writing skill."
---

# Paper Figures and Tables

Figures and tables for experimental papers that a reader can trust at a glance: one style per algorithm across the whole paper, axes that do not exaggerate, captions that stand alone, and every number read from a data file.

## Rules that always apply

- **Never invent data.** Figures read measurements from data files; tables hold the author's numbers or `\TODO{...}` placeholders. Example data in the templates is synthetic and must never be presented as a result.
- **One role per algorithm for the whole paper.** Color, marker, and dash come from the palette role (`algOurs`, `algBaseA`, ...), never a raw color. The same algorithm looks the same in every plot, diagram, and table.
- **Color never carries meaning alone.** Every series differs in color, marker, and dash, so the figure works in grayscale and for color-blind readers.
- **Colors mean algorithms.** Phases, instances, or query types get grays or line styles.
- **Names match the text.** Algorithm, column, and axis names are the ones the paper uses, with units in brackets: `query time [ms]`.
- **Captions are self-contained:** what is plotted against what, instance, query set, what markers and bands mean, number of repetitions. The caption describes; the text interprets.
- **Build and look.** Every figure is a standalone file that compiles to its own PDF. If LaTeX or gnuplot is available, build the PDF and look at it before answering.

## Workflow

1. Decide what is needed and read the reference:

| Task | Read |
|---|---|
| plot, chart, diagram, gnuplot, pgfplots, TikZ, palette, colors | `references/figures.md` |
| results table, instance table, bounds table | `references/tables.md` |

2. Pick the closest template from `assets/`, copy it, and point it at the data file.
3. Build with `make` in the figures directory; open the PDF; fix what is wrong.
4. Run the checklist in the reference file.

## Assets

```
assets/
  palette/colors.tex, colors.gp   one palette, same roles in LaTeX and gnuplot (Okabe–Ito default, KIT switch)
  latex/figure-preamble.tex       fonts and macros shared by all standalone figures
  latex/paper-macros.tex          paper preamble: booktabs, siunitx, theorems, \algname, \TODO, \GAP
  figures/Makefile                make → build/*.pdf (gnuplot figures as build/gp-*.pdf)
  figures/data/*.dat              synthetic example data
  figures/pgfplots/*.tex          scaling, phases, ranks, tradeoff, example-instance (TikZ), palette-check
  figures/gnuplot/*.gp            scaling, phases (gnuplot 5, cairolatex)
  tables/query-table.tex          results table with marker columns and grouped headers
```

Copy `palette`, `latex`, and `figures` into the paper repository with the same relative layout (or adjust the `\input` paths). Include figures with `\includegraphics{figures/build/<name>.pdf}` and no `width=`; set the size in the figure source so the figure font matches the caption font.

## Choosing the form

| Data | Use |
|---|---|
| about 20 numbers or fewer, or values needed exactly | table |
| a quantity over a numeric parameter (size, cores, rank) | line plot with points |
| one value per instance, many instances | scatter plot, never connected |
| time split into phases | stacked bars in grays, or phase columns in a table |
| configurations trading one cost for another | tradeoff plot, all baselines included |

No 3D plots, pie charts, or decorative fills.
