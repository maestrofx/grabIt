#!/bin/bash

filename="webops-perf"
url="http://www.oreilly.com/webops-perf/free/"

lynx --dump $url | awk '/http/{$1=$200""; print}' | grep -E -i -w 'csp' > $filename

#cp $filename.txt{,.pdf,.mobi,.epub}

replace "free/" "free/files/" -- $filename
replace "?intcmp=il-data-free-lp-lgen_free_reports_page" "" -- $filename

sed 's/csp*/pdf/g' $filename >  $filename.pdf.txt
sed 's/csp*/mobi/g' $filename > $filename.mobi.txt
sed 's/csp*/epub/g' $filename > $filename.epub.txt


#this part to download all the files listed in  filename.*

for i in $filename.* 
do
    wget -c -i  "$i" # use "" to avoid the url containing spaces
done

