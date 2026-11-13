# Build every figure as a standalone PDF in build/.
#   make            all figures
#   make pgf        only pgfplots / TikZ figures (pgfplots/*.tex)
#   make gp         only gnuplot figures (gnuplot/*.gp), named build/gp-*.pdf
#   make build/scaling.pdf   one figure
#   make clean
# Open the PDFs directly to check a figure; include the same files in the
# paper with \includegraphics{figures/build/<name>.pdf}.
# Run make from this directory: all paths in the sources are relative to it.

BUILD   := build
LATEX   := pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD)
GNUPLOT := gnuplot

PGF_SRC := $(wildcard pgfplots/*.tex)
GP_SRC  := $(wildcard gnuplot/*.gp)
PGF_PDF := $(patsubst pgfplots/%.tex,$(BUILD)/%.pdf,$(PGF_SRC))
GP_PDF  := $(patsubst gnuplot/%.gp,$(BUILD)/gp-%.pdf,$(GP_SRC))

# Shared inputs: a change to the palette, the preamble, or any data file
# rebuilds the figures.
SHARED  := ../palette/colors.tex ../palette/colors.gp \
           ../latex/figure-preamble.tex $(wildcard data/*)

.PHONY: all pgf gp clean
all: pgf gp
pgf: $(PGF_PDF)
gp:  $(GP_PDF)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.pdf: pgfplots/%.tex $(SHARED) | $(BUILD)
	$(LATEX) $< > $(BUILD)/$*.out || (tail -n 30 $(BUILD)/$*.log; exit 1)

$(BUILD)/gp-%.pdf: gnuplot/%.gp $(SHARED) | $(BUILD)
	$(GNUPLOT) $<
	$(LATEX) $(BUILD)/gp-$*.tex > $(BUILD)/gp-$*.out || (tail -n 30 $(BUILD)/gp-$*.log; exit 1)

clean:
	rm -rf $(BUILD)
