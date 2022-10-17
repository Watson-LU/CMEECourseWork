#!/bin/bash
pdflatex ${1%.*}.tex        ##use {filename%.*} to ignore the useless file's extension
bibtex ${1%.*}
pdflatex ${1%.*}.tex
pdflatex ${1%.*}.tex
evince ${1%.*}.pdf &

##Clean up
rm *.aux
rm *.log
rm *.bbl
rm *.blg

##final try to use 'bash CompileLaTeX.sh FirstExample.tex ''