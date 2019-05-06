NAME := report
IMGS := $(wildcard img/*.svg)
INPUTS := report/meta.yml \
	report/1_introduction.md \
	report/2_definition_probleme.md \
	report/3_unikernels.md \
	report/4_differents_problemes.md \
	report/5_differentes_solutions.md \
	report/6_unik.md \
	report/7_evaluation_performances.md \
	report/8_conclusion.md

.PHONY: report
report: $(NAME).pdf

%.pdf: %.tex $(IMGS:.svg=.pdf)
	xelatex $*
	yes | bibtex $*
	xelatex $*
	xelatex $*

img/%.pdf: img/%.svg
	rsvg-convert -f pdf -a -o $@ $<

$(NAME).tex: $(INPUTS)
	pandoc -s \
		--lua-filter=filter.lua \
		--template=report/template.tex \
		--natbib -N -o $@ $(INPUTS)

.PHONY: clean
clean:
	$(RM) img/*.pdf $(NAME).*