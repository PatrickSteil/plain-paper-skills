# Figures

Contents: Workflow, Palette and styles, Choosing a plot, Axes, Curves, Measurement noise, Ticks and grids, Captions, Common plots in algorithm engineering, Diagrams, Checklist.

The plotting rules follow Peter Sanders, "Presenting Data from Experiments in Algorithmics" (https://ae.iti.kit.edu/documents/people/sanders/papers/mess.pdf). Read it once; the checklist at its end is the best one-page summary.

## Workflow

Every figure is a standalone file that compiles to its own PDF. You look at that PDF, and the paper includes the same PDF.

```
figures/
├── Makefile              make → build/*.pdf
├── data/                 measurement files (one per figure or experiment)
├── pgfplots/*.tex        pgfplots plots and TikZ diagrams (standalone class)
├── gnuplot/*.gp          gnuplot scripts (cairolatex standalone terminal)
└── build/*.pdf           what you preview and what the paper includes
palette/colors.tex, colors.gp   the palette (Okabe–Ito default, KIT switch), same roles in both
latex/figure-preamble.tex       fonts and macros shared with the paper
```

- Templates for all of this are in `assets/`. Copy `assets/palette`, `assets/latex`, and `assets/figures` into the paper repository and keep the relative layout, or adjust the `\input` paths.
- Build: `make` in the figures directory. One figure: `make build/scaling.pdf`. gnuplot figures appear as `build/gp-<name>.pdf`.
- Include: `\includegraphics{figures/build/scaling.pdf}`. Do not pass `width=`; set the size in the figure source (`width`, `height` in pgfplots; `size` in the gnuplot terminal) so that the figure font has the same size as the caption font.
- Both tools set text with LaTeX: pgfplots natively, gnuplot through the `cairolatex` terminal. Labels can use the paper's math and the `\algname` macro.
- Pick one tool per paper if you can. If you mix them, the shared palette and preamble keep the look identical.
- Keep data and plotting separate. The experiment writes a data file; the figure reads it. Never type measured numbers into a figure source by hand.

When the assistant generates a figure, it writes the source file and, if it can run LaTeX or gnuplot, builds the PDF and looks at it before answering. It never fills a data file with invented values. Example data in the templates is labeled synthetic.

## Palette and styles

The default palette is Okabe–Ito, designed for color vision deficiency. The KIT corporate design (definitions from the KIT Beamer template by Erik Burger and Christian Hammer) is available as a switch for papers that follow it. Both live in `assets/palette/colors.tex` and `colors.gp`, with the same role names.

| Role | Okabe–Ito (default) | KIT (switch) | Marker, dash |
|---|---|---|---|
| `ours` | blue `#0072B2` | kit-green100 `#009682` | filled circle, solid |
| `baseA` | vermillion `#D55E00` | kit-red100 `#BF0000` | filled square, dashed |
| `baseB` | bluish green `#009E73` | kit-blue100 `#4563AB` | filled triangle, dotted |
| `baseC` | reddish purple `#CC79A7` | kit-orange100 `#FF8C00` | filled diamond, dash-dot |
| `baseD` | orange `#E69F00` | kit-blue50 `#A3B0D4` | filled pentagon, densely dashed |
| `baseE` | sky blue `#56B4E9` | kit-green50 `#80C9BF` | open circle, loosely dashed |
| `reference` | black | black | no marker, dotted |
| neutral (`figGray`) | `#BBBBBB` | `#BBBBBB` | grid, pruned elements |

Switching: put `\newcommand*{\figpalette}{kit}` before `\input{colors}` (or change the default in `colors.tex`), and set `PALETTE = 'kit'` in gnuplot (or change the default in `colors.gp`). Build `palette-check.pdf` to see all roles.

If you switch to KIT: color vision deficiency was checked by simulation (Machado et al. 2009 matrices, CIE76 color difference) when the KIT palette was added:

- The four KIT main colors and black stay clearly distinguishable for protanopia, deuteranopia, and tritanopia. The weakest pair is green and blue under tritanopia, comparable to the weakest pairs of Okabe–Ito.
- The 50 % tints (`baseD`, `baseE`) are only marginally distinguishable from their full tones. With more than four algorithms in one plot, markers and dashes carry the difference. Prefer fewer curves.
- KIT red at 50 % is almost identical to KIT green for protanopia. Do not use it as a role.
- KIT yellow is nearly white. Never use it for lines or markers.
- Use KIT only where the corporate design is required; otherwise keep Okabe–Ito.

Rules:

- **One color per algorithm for the whole paper.** Assign roles once in `colors.tex` (`\colorlet{algRAPTOR}{algBaseA}`) and mirror them in `colors.gp`. Every plot, diagram, and table marker uses the role, never a raw color.
- **Roles 1 and 2 are the most important pair**: the own algorithm and the strongest baseline. They get the best separated colors.
- **Every series differs in color, marker, and dash pattern.** The figure must still work printed in grayscale and for color-blind readers. Never let color alone carry meaning.
- **Colors mean algorithms.** Another categorical dimension in the same paper (phases, instances, query types) gets gray shades or line styles, not palette colors. Otherwise one color means two things.
- **Fills** use the role color mixed with white (`algOurs!70`). For KIT colors this gives the official 70 % tints.
- **Same colors in pgfplots and gnuplot.** The figure preamble loads `xcolor` with the `rgb` option, so pgfplots converts the CMYK KIT colors to the same RGB values that `colors.gp` uses. The paper itself may keep CMYK (for example for print); the difference is only the color model, not the color.
- Six roles are enough. A figure that needs more curves needs fewer curves (see Curves).

## Choosing a plot

| Data | Use |
|---|---|
| about 20 numbers or fewer | a table (`tables.md`) |
| a quantity over a numeric parameter (size, cores, rank, speed) | line plot with points |
| one value per instance, few instances | table, or bar chart if a visual comparison matters |
| one value per instance, many instances | scatter plot, never connected |
| time split into phases | stacked bars, or phase columns in a table |
| distribution per parameter value | median line with quartile band, or box plots |
| configurations that trade one cost for another | tradeoff plot: one axis per cost, one point per configuration |
| distribution of one quantity | histogram with the bins defined in the caption |

Do not use 3D plots, pie charts, or decorative fills. If a 3D plot seems necessary, plot 2D cross-sections instead.

## Axes

- **Choose the x unit to remove a parameter** when theory says how it scales (Sanders plots against k/t₀ instead of k).
- **Log x for ranges over orders of magnitude.** Measure at powers of two and put the ticks at powers of two, not powers of ten. Do not measure at constant offsets and then plot on a log axis.
- **Linear x for small ranges** (up to about 8 cores) or to show periodic effects.
- **Normalize y to remove known growth.** If time is expected to be Θ(n log n), plot time / (n log n) on a linear axis instead of time on log-log axes. Name the quantity: "time per element", "time per comparison", "speedup over X", "competitive ratio".
- **Start y at 0** when the reader will compare heights or read a claim like "much faster for large n" from the plot. A range from the minimum to the maximum makes a 1 % change look like a 400 % change. Exceptions: a natural lower bound (start there and say why), or log scales.
- **Clip useless parts** of a curve (an algorithm that is far off for large inputs) and say so in the caption.
- **Aspect ratio** a bit wider than high (about the golden ratio) when nothing else decides it. Sanders' "banking to 45°" is the better rule when slopes matter.
- **Units in the axis label** in brackets: `query time [ms]`.

## Curves

- **Up to about seven smooth curves** fit in one plot; three complicated ones may already be too many.
- To reduce curves: drop clearly dominated or equivalent algorithms (say so in the caption); split into two plots with a zoom; or plot the ratio of the new algorithm to the best of the others.
- **Points mark measurements.** Lines only connect points of the same curve as a visual aid. A line without points claims the curve is accurate between measurements; use it only for dense measurements or analytic curves.
- **Splines only** if you believe the interpolation.
- **Never connect points of unrelated instances.**
- **Same algorithm, same style in every figure**, with the same y range where readers compare figures.
- **Legend** inside the empty corner (curves usually rise to the upper right, so upper left), in the order of the curves at the right end, without cryptic abbreviations. Label curves directly if space allows.

## Measurement noise

- For randomized algorithms or random inputs, repeat until the standard error is small, then state the bound in the caption instead of drawing error bars ("standard error below 1 %").
- For running times of deterministic code, the noise is not random (interrupts, frequency scaling). Use the median of repetitions, and if bars are needed, use min–max or a percentile range. Say which in the caption, with the number of repetitions.
- If an error bar is drawn, the caption says what it is.

## Ticks and grids

- A few round numbers per axis. Use exponent notation (2^20) once numbers get long.
- No grid by default. If reading off values matters, use thin light-gray grid lines behind the data.
- Maximize the share of ink that shows data: no frames around legends, no background colors, no shadows.

## Captions

The caption makes the figure self-contained. It says:

- what is plotted against what, on which instance(s), with which query set;
- what the markers, bands, and bars mean (median, quartiles, min–max, mean ± standard error);
- algorithm parameters used, if not the defaults stated in the text;
- the number of repetitions or queries;
- what to see in it, in one sentence, if that is not obvious;
- bin boundaries for histograms ("bar 2^i covers [2^(i−1), 2^i)").

The text interprets the figure in its own paragraph. The caption does not argue.

## Common plots in algorithm engineering

Templates for the first four are in `assets/figures`.

- **Scaling plot** (`scaling`): time per element against input size, log x. Shows crossovers; keep the region where a baseline wins.
- **Phase breakdown** (`phases`): stacked bars per algorithm, phases in grays, totals at the bar ends. Order of bars equals row order in the results table.
- **Rank plot** (`ranks`): query time against Dijkstra or geographic rank 2^r, median with interquartile band and min–max lines, log y. Shows that averages hide no slow queries, or shows that they do.
- **Tradeoff plot** (`tradeoff`): query time against additional space over a parameter sweep, with all baselines, including faster ones. A baseline without preprocessing is a horizontal line, since it has no point on a log space axis.
- **Palette check** (`palette-check`): all roles in one plot. Build it after changing the palette or the roles and look at it in grayscale too.
- **Parameter study**: preprocessing time and output size against a tuning parameter (for example, core degree and witness limit in ULTRA). Mark the chosen value and say why it was chosen.
- **Parallel scaling**: time or speedup against threads, linear x for small machines. Include the ideal-speedup line as `reference`. Show the sequential non-parallel time as a point at one thread.
- **Histogram**: distribution of a structural quantity (shortcut lengths, label sizes) with explained bins. Split bars by a cause if relevant (for example, splitting shortcuts by whether the stops were connected in the transfer graph, to separate data artifacts).

## Diagrams

Example instances, data structures, and algorithm illustrations are TikZ diagrams in `pgfplots/` (template: `example-instance.tex`), built and included like plots.

- One idea per diagram, on the smallest instance that shows it.
- The paper's notation in labels ($s$, $t$, $T_1$, $\tau_{\mathrm{arr}}$).
- The same palette and roles. Within a diagram a color means one thing, stated in the caption ("blue: journey found by the algorithm; dashed gray: pruned transfers").
- Line style repeats the meaning of color.
- A counterexample diagram shows the rule, the instance, and both outputs.
- A caption explains the example fully, so the reader can follow it without the text.

## Checklist

From Sanders, in the order he suggests applying them, plus the palette rules.

- Can a table become a figure, or should a small figure be a table?
- Can the number of curves be reduced? How many figures are needed?
- Does the x unit remove a parameter? Log x? Measured at the tick base?
- Is the x range adequate, and are measurements neither too dense nor too sparse?
- Should y be normalized? Log y? Does y start at 0, and if not, is that misleading?
- Should useless parts of a curve be clipped?
- Are curves well separated? Is noise small enough? Are error bars needed, and does the caption say what they show?
- Points for measurements, lines only within one curve, no lines between unrelated instances.
- Different color, marker, and dash per curve; the same style for the same algorithm in every figure; colors from the palette roles only; no KIT yellow for lines if the KIT palette is used.
- Legend in the right order, not covering data.
- Caption self-contained and sufficient to reproduce the measurement.
- The PDF was built and looked at.
