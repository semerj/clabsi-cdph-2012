#!/bin/bash

wget http://cdph.ca.gov/programs/hai/Documents/2012-CLABSI-T{03..40}.pdf

for f in *.pdf
do
  qpdf --password= --decrypt $f out-$f
  pdftotext -layout out-$f
done

python clabsi2012.py

rm -r *.pdf *.txt
