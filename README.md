clabsi-cdph-2012
================

Liberating California's 2012 CLABSI data from PDF documents

> Detailed, hospital-specific CLABSI and CLIP information for each of the patient care locations can be accessed by clicking on either Table 1 or Table 2 above and then clicking on the link for each patient care location. Detailed information for each patient care location includes an alphabetical list of California hospitals; numbers of CLABSI; central line days; and patient days; CLABSI rates and their 95% confidence intervals; symbols indicating patient care locations that were statistically higher, lower, or no different from statewide average CLABSI rates; and CLIP adherence percentages for critical care patient care locations.

More information [here](http://www.cdph.ca.gov/programs/hai/Pages/CentralLineAssociatedBloodstreamInfections-CLABSI-Reports.aspx).

You'll need:
* [qpdf](http://qpdf.sourceforge.net/) for decryption
* [pdftotext](http://www.bluem.net/en/mac/packages/) for text conversion and document layout preservation
* [Pandas](http://pandas.pydata.org/) for data munging

Make sure both `dostuff.sh` and `clabsi2012.py` are the ONLY documents in the same directory. Then run `dostuff.sh`. Boom.
