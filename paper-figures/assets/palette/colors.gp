# colors.gp -- the same palette and roles as colors.tex, for gnuplot 5.
# Keep the role mapping identical to colors.tex.
#
# Two palettes; PALETTE selects one (default 'okabeito'):
#   okabeito  Okabe & Ito, designed for color vision deficiency.
#   kit       KIT corporate design. Hex values are what xcolor computes from
#             the KIT Beamer template definitions (CMYK converted to RGB), so
#             gnuplot and pgfplots figures show the same colors.
# To switch, set PALETTE = 'kit' before loading this file, or change the
# default below (and in colors.tex).
#
# Every role differs in color, point type, and dash type, so plots stay
# readable in grayscale and for color-blind readers.
#
# Usage in a script:   load '../palette/colors.gp'
#                      plot 'f.dat' using 1:2 with linespoints lt OURS title 'Ours'

if (!exists("PALETTE")) PALETTE = 'okabeito'

if (PALETTE eq 'kit') {
    C_OURS  = '#009682'   # kit-green100
    C_BASEA = '#BF0000'   # kit-red100
    C_BASEB = '#4563AB'   # kit-blue100
    C_BASEC = '#FF8C00'   # kit-orange100
    C_BASED = '#A3B0D4'   # kit-blue50
    C_BASEE = '#80C9BF'   # kit-green50
} else {
    C_OURS  = '#0072B2'   # blue
    C_BASEA = '#D55E00'   # vermillion
    C_BASEB = '#009E73'   # bluish green
    C_BASEC = '#CC79A7'   # reddish purple
    C_BASED = '#E69F00'   # orange
    C_BASEE = '#56B4E9'   # sky blue
}

# Role indices. Rename them to your algorithms, but keep one role per
# algorithm for the whole paper, matching colors.tex.
OURS  = 1
BASEA = 2
BASEB = 3
BASEC = 4
BASED = 5
BASEE = 6
REF   = 7

# pt: 7 filled circle, 5 filled square, 9 filled triangle, 13 filled diamond,
#     15 filled pentagon, 6 open circle.  dt: 1 solid, 2 dashed, 3 dotted,
#     4 dash-dot, 5 dash-dot-dot.
set linetype OURS  lc rgb C_OURS  lw 1.5 pt 7  ps 0.7 dt 1
set linetype BASEA lc rgb C_BASEA lw 1.5 pt 5  ps 0.7 dt 2
set linetype BASEB lc rgb C_BASEB lw 1.5 pt 9  ps 0.8 dt 3
set linetype BASEC lc rgb C_BASEC lw 1.5 pt 13 ps 0.8 dt 4
set linetype BASED lc rgb C_BASED lw 1.5 pt 15 ps 0.8 dt 5
set linetype BASEE lc rgb C_BASEE lw 1.5 pt 6  ps 0.7 dt 2
set linetype REF   lc rgb '#000000' lw 1.0 pt 0       dt 3
set linetype cycle 7

# Neutral colors for non-data ink.
GRAY = '#BBBBBB'
set border lc rgb '#000000' lw 0.8
set grid back lc rgb '#DDDDDD' lw 0.5 dt 1
unset grid   # enable per figure only if reading off values matters
