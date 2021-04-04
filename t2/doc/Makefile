# ---------------------------------------------------------
# type "make" command in Unix to create report.pdf 
# ---------------------------------------------------------

#list of LibreOffice Draw files
FILE=report
LODFIGS = $(patsubst %.odg,%.pdf,$(wildcard *.odg))

#------------------------------------------------------------

all: $(FILE).pdf
	evince $< &

$(FILE).pdf: $(wildcard *.tex) $(LODFIGS) python oct-t2 ngs1 ngs2 ngs3.log ngs4.log ngs5.log
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex
	pdflatex  $(FILE).tex
	

#############################################################
#------------------------------------------------------------
#############################################################

python:
	python2.7 ../DADOS/t2_datagen.py 95814 > data.txt

#------------------------------------------------------------

oct-t2:
	octave ../mat/oct_nos_t2.m > octave.log

#------------------------------------------------------------

ngs1: ngs1.log
	
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	

ngs2: ngs2.log
	
	$(eval NGSFIGS2=$(shell grep _FIG2 $< | sed 's/_FIG2//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS2=$(addsuffix .ps, $(NGSFIGS2)))
	$(eval NGSTABS2=$(shell grep _TAB2 $< | sed 's/_TAB2//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach z, $(NGSTABS2), sed -n '/^$z_TAB2/,/^$z_END2/{p;/^$z_END2/q}' $< | grep -v $z_TAB2 | grep -v $z_END2 | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(foreach z, $(NGSFIGPS2), ps2pdf $z;)
	
	
ngs1.log: ../sim/ngs_t2_1.cir
	ngspice -b $< -o $@
	
ngs2.log: ../sim/ngs_t2_2.cir
	ngspice -b $< -o $@

ngs3.log: ../sim/ngs_t2_3.cir
	ngspice -b $< -o $@
	
ngs4.log: ../sim/ngs_t2_4.cir
	ngspice -b $< -o $@

ngs5.log: ../sim/ngs_t2_5.cir
	ngspice -b $< -o $@
	

	
#############################################################
#------------------------------------------------------------
#############################################################
#convert libreoffice draw figures to pdf

%.pdf: %.odg
	soffice --headless --convert-to pdf $<

clean:
	@rm -rf *.aux *.bbl *.blg *.glg *.glo *.gls *.ilg *.ist *.lof
	@rm -rf *.log *.lot *.nlo *.nls *.out *.toc *~ *.*% ./*.pdf ./*.ps ./*.txt
	@rm -rf *_tab.tex octave-workspace *.eps

.PHONY: all clean ngspice octave


