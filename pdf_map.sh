wget http://cdph.ca.gov/programs/hai/Documents/2012-CLABSI-T{03..40}.pdf
mkdir output
mkdir text
for f in *.pdf; do qpdf --password= --decrypt $f output/out-$f; done
cd output/
for f in *.pdf; do pdf2txt.py -o ../text/${f%.pdf}.txt $f; done