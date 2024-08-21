objects := $(wildcard content/*.md)

HTML := $(patsubst content/%.md,output/%.html,$(objects))
PDF := $(patsubt content/%.md,output/%.pdf,$(objects))

STYLE := ./static/css/pandoc.css

.PHONY : all
all : $(HTML) $(PDF)

$(HTML) : output/%.html : content/%.md $(STYLE)
	@echo --- Generating HTML ---
	@mkdir -p output
	@pandoc -s --css $(STYLE) --embed-resources --standalone -o $@ $<

$(PDF) : output/%.pdf : content/%.md
	@echo --- Generating PDF ---
	@mkdir -p output
	@pandoc -V papersize:a4 --pdf-engine xelatex -o $@ $<

.PHONY : clean
clean :
	@echo --- Deleting generated files ---
	@-rm -rf output
