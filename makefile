# Tobias Gersdorf, 2021
# Makefile for LaTeX documents.
# prerequisites are LaTeX and latexmk installed.

PROJECT_NAME=document
MAIN_FILE=LaTeX

PDF=$(OUTPUT_DIR)$(PROJECT_NAME).pdf

OUTPUT_DIR=./out/
SYNCTEX_ON=1

TEX=latexmk -interaction=nonstopmode -file-line-error -output-directory=$(OUTPUT_DIR) -synctex=$(SYNCTEX_ON) -jobname=$(PROJECT_NAME) -pdf -use-make
BIB=bibtex

SRCS=$(shell find . -type f -name '*.tex')


all: $(PDF) out/*.aux

$(PDF) out/*.aux: $(SRCS)
	latexmk
	cp $(PDF) $(OUTPUT_DIR)$(MAIN_FILE).pdf
	cp $(OUTPUT_DIR)document.synctex.gz $(OUTPUT_DIR)$(MAIN_FILE).syntex.gz

launch-code:
	code $(OUTPUT_DIR)$(PROJECT_NAME).pdf

launch-web:
	$(BROWSER) $(OUTPUT_DIR)$(PROJECT_NAME).pdf

clean:
	latexmk -c

clean-all:
	rm $(OUTPUT_DIR) -rf
