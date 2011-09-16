pdflatex=pdflatex
bibtex=bibtex

SRC=main.tex 
AUX=$(SRC:.tex=.aux)
PDF=$(SRC:.tex=.pdf)

default: all

all: pdf

pdf: $(PDF)

$(PDF): $(SRC) $(BIB)
	-rm -f $(AUX)
	$(pdflatex) $<
	$(pdflatex) $<

view: pdf
	open $(PDF)

fax: $(PDF)
	-echo "converting PDF to fax format using ghostscript"
	-gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=dfaxhigh -sOutputFile=fax.g3.%d -q main.pdf
	-scp fax.g3.* root@nibbler:/tmp
	-echo "the files have been copied to nibbler:/tmp. run: "
	-echo "# sendfax <fax number> fax.g3.1 fax.g3.2 ..."

clean:
	-rm -f *~
	-rm -f $(AUX)
	-rm -f *.log
	-rm -f *.bbl
	-rm -f *.out
	-rm -f *.blg
	-rm -f fax.g3.*

.PHONY: default all clean

