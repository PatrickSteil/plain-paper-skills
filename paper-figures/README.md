# paper-figures

A Claude skill for plots, diagrams, and results tables in experimental papers on algorithms and systems. Every figure is a standalone pgfplots, gnuplot, or TikZ file that builds to its own PDF, which you open to check and include in the paper unchanged. One palette assigns each algorithm a fixed color, marker, and dash for the whole paper.

The plotting rules follow Peter Sanders, "Presenting Data from Experiments in Algorithmics". For the paper's prose, use the companion skill `algorithm-paper-writing`. The two skills work independently.

## Contents

```
SKILL.md                     entry point: rules that always apply, workflow, assets
references/
  figures.md                 plotting rules, palette, workflow, common plots, diagrams, checklist
  tables.md                  booktabs/siunitx tables, marker columns, captions
assets/
  palette/                   colors.tex and colors.gp: Okabe–Ito (default) or KIT, same roles
  latex/                     figure-preamble.tex (shared by figures), paper-macros.tex
  figures/                   Makefile, synthetic data, pgfplots/TikZ and gnuplot templates
  tables/query-table.tex     results table template
```

## Installation

Copy the `paper-figures` folder into your skills directory (for Claude Code: `~/.claude/skills/`), or upload the zipped folder in Claude's skill settings.

## The palette

The default is Okabe–Ito ("Color Universal Design"), designed for color vision deficiency. The KIT corporate design palette (colors from the KIT Beamer template by Erik Burger and Christian Hammer, version 2.0) is available as a one-line switch for papers that follow it.

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

- **Roles.** Each algorithm gets one role for the whole paper. Rename the roles in `colors.tex` (for example `\colorlet{algRAPTOR}{algBaseA}`) and mirror the change in `colors.gp`.
- **Markers and dashes.** Every series differs in color, marker, and dash pattern, so figures also work in grayscale.
- **Gray for other dimensions.** Phases, instance types, and other categories use gray shades, so that a color always means an algorithm.
- **Switching.** In LaTeX, put `\newcommand*{\figpalette}{kit}` before `\input{colors}`. In gnuplot, set `PALETTE = 'kit'` before `load 'colors.gp'`.
- **Checking.** `make build/palette-check.pdf` shows all roles at once.
- **KIT and color vision deficiency.** Checked by simulating protanopia, deuteranopia, and tritanopia (Machado et al. 2009): the four KIT main colors and black stay distinguishable; the 50 % tints (roles 5 and 6) only marginally, so markers and dashes carry the difference; KIT red at 50 % and KIT yellow are not used for lines.

## The figure pipeline

1. Copy `assets/palette`, `assets/latex`, and `assets/figures` into your paper repository, keeping the relative layout (or adjust the `\input` paths).
2. Set the font in `assets/latex/figure-preamble.tex` to the one your paper uses, so figure text matches the body text.
3. Put measurement files in `figures/data/`. Each figure reads its data from a file; numbers are never typed into a figure.
4. Copy a template from `figures/pgfplots/` or `figures/gnuplot/` and adapt it.
5. Run `make` in the figures directory. Every figure becomes a PDF in `figures/build/`; gnuplot figures are named `gp-<name>.pdf`. Open the PDF to check it.
6. Include the same PDF in the paper:

   ```latex
   \begin{figure}[t]
     \centering
     \includegraphics{figures/build/scaling.pdf}
     \caption{...}
     \label{fig:scaling}
   \end{figure}
   ```

   Set the figure size in the source, not with `width=` in `\includegraphics`, so the font size stays right.

gnuplot figures use the `cairolatex` terminal in standalone mode: gnuplot draws the graphics, and LaTeX sets all text. Both tools therefore produce the same fonts and can use the paper's macros.

Templates:

| Template | Shows |
|---|---|
| `scaling` (pgfplots, gnuplot) | time per element against input size, log x with powers of two, y from 0, crossover kept |
| `phases` (pgfplots, gnuplot) | running time split into phases, grays for phases, totals at the bar ends |
| `ranks` (pgfplots) | query time by rank: median line, interquartile band, min–max lines |
| `tradeoff` (pgfplots) | time against space over a parameter sweep, with all baselines including the faster one |
| `example-instance` (TikZ) | small example instance in the palette |
| `palette-check` (pgfplots) | all roles at once, for checking the palette in color and grayscale |

All example data is synthetic and labeled as such.

## Requirements

- LaTeX: pgfplots (with the `fillbetween` library), pgfplotstable, standalone, xcolor, booktabs, siunitx, amsthm, cleveref, xspace, algorithm2e. TeX Live includes all of them.
- gnuplot 5 with cairo terminals, for the gnuplot templates.
- `make`.

## Testing status

- The pgfplots and TikZ templates, the table template, and `paper-macros.tex` were compiled with pdflatex (TeX Live 2023), and the output was inspected visually.
- The gnuplot templates were written for gnuplot 5 but **not run**, because gnuplot was not available while the skill was written. If one fails, check the column-name syntax in `using` first; numeric columns (`using 1:3`) always work.

## Sources

- Peter Sanders. Presenting Data from Experiments in Algorithmics. https://ae.iti.kit.edu/documents/people/sanders/papers/mess.pdf
- Masataka Okabe, Kei Ito. Color Universal Design (CUD): How to make figures and presentations that are friendly to colorblind people. 2008.
- Erik Burger, Christian Hammer. LaTeX-Beamer template for KIT design, version 2.0 (source of the KIT color definitions).
- Gustavo M. Machado, Manuel M. Oliveira, Leandro A. F. Fernandes. A Physiologically-based Model for Simulation of Color Vision Deficiency. IEEE TVCG, 2009.
