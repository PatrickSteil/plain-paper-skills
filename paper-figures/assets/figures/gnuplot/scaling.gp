# scaling.gp -- gnuplot version of pgfplots/scaling.tex (same rules, same look).
#
# Pipeline: gnuplot writes a standalone LaTeX file (cairolatex terminal), and
# pdflatex turns it into build/gp-scaling.pdf. All text is typeset by LaTeX,
# so fonts and macros match the paper. Run from the figures directory:
#     make build/gp-scaling.pdf
# Needs gnuplot 5.x with the cairo terminals.
# NOTE: written for gnuplot 5 but not run when this skill was created
# (no gnuplot available). If something fails, check the column-name syntax
# in "using" first; numeric columns (using 1:3) always work.

set terminal cairolatex pdf standalone size 8cm,5cm \
    header "\\input{../latex/figure-preamble}\n\\input{../palette/colors}"
set output 'build/gp-scaling.tex'
load '../palette/colors.gp'

set logscale x 2
set xrange [2**9.5:2**24.5]
set xtics (2**10, 2**14, 2**18, 2**22)
set format x '$2^{%L}$'          # %L = exponent in the current log base
set yrange [0:21]                # start at 0, see figures.md
set xlabel 'input size $n$'
set ylabel 'time per element [ns]'
set key top left Left reverse samplen 2.5 spacing 1.1

DATA = 'data/scaling.dat'
# Order = legend order = order of the curves at the right end.
plot DATA using 'n':'baseA' with linespoints lt BASEA title '\algname{BaseA}', \
     DATA using 'n':'ours'  with linespoints lt OURS  title '\algname{Ours}', \
     DATA using 'n':'baseB' with linespoints lt BASEB title '\algname{BaseB}'

set output
