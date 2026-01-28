TEX=main.tex
PDF=main.pdf

all: $(PDF)

$(PDF): $(TEX)
	@if command -v latexmk >/dev/null 2>&1; then \
		latexmk -pdf -interaction=nonstopmode -halt-on-error $(TEX); \
	else \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX); \
		pdflatex -interaction=nonstopmode -halt-on-error $(TEX); \
	fi

clean:
	@if command -v latexmk >/dev/null 2>&1; then \
		latexmk -C; \
	else \
		rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk *.synctex.gz; \
	fi

.PHONY: all clean
