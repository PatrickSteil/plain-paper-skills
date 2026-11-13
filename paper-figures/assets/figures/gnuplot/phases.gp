# phases.gp -- gnuplot version of pgfplots/phases.tex, as vertical bars.
# Colors identify algorithms in the paper; phases are another dimension and
# get neutral grays (the same grays as the pgfplots version).
# Run from the figures directory:  make build/gp-phases.pdf
# NOTE: written for gnuplot 5 but not run when this skill was created.

set terminal cairolatex pdf standalone size 8cm,5cm \
    header "\\input{../latex/figure-preamble}\n\\input{../palette/colors}"
set output 'build/gp-phases.tex'
load '../palette/colors.gp'

set style data histograms
set style histogram rowstacked
set style fill solid 1.0 border rgb '#333333'
set boxwidth 0.55
set yrange [0:45]
set ylabel 'mean query time [ms]'
set xtics nomirror scale 0
set key top center horizontal samplen 1.5 width 1

DATA = 'data/phases.dat'
# Grays: black!10, black!40, black!70 in xcolor terms.
plot DATA using 'init':xtic('\algname{'.strcol(1).'}') lc rgb '#E6E6E6' title 'initialization', \
     DATA using 'scan'  lc rgb '#999999' title 'route scans', \
     DATA using 'relax' lc rgb '#4D4D4D' title 'relaxation', \
     DATA using 0:($2+$3+$4):(sprintf('%.1f', $2+$3+$4)) \
          with labels offset 0,0.8 notitle

set output
