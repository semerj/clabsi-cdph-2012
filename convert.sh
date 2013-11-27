wget http://cdph.ca.gov/programs/hai/Documents/2012-CLABSI-T{03..40}.pdf
mkdir output
for f in *.pdf; do qpdf --password= --decrypt $f output/out-$f; done
for f in output/*.pdf; do pdftotext -layout $f; done
