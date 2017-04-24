# openn_csv
*this is a new repository on 4/24/2017, other files will be added as the collection grows*

The sample files generate a CSV of descriptions of manuscripts in the Schoenberg Collection at UPenn. 

* LJS_doc_list.xml lists the URLs for the LJS XML files on OPenn
* tei2csv.xsl is the script
* empty.xml is the file that needs to be processed by tei2csv.xsl
* openn_ljs.csv is the output
* openn_ljs_clean.csv is the output cleaned up in Google Refine
* google_refine_script.json is the history of cleaning the .csv file in Google Refine

To generate a CSV of other manuscripts, modify the doc_list or create a new one.

This script is built to run against the LJS collection. It may need to be modified to run against other collections.
