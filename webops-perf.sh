#!/bin/bash

filename="web-platform"
url="http://www.oreilly.com/web-platform/free/"

#get all the downloadable links
lynx --dump $url | awk '/http/{$1=$200""; print}' | grep -E -i -w 'csp' > $filename

#clean strings are not necessary
#for row in $(cat $filename); do $row=${$row%?int*}

for row in $(cat web-platform); do row=${row%?int*};  echo $row; done > $filename.final
mv $filename.final $filename

#cp $filename.txt{,.pdf,.mobi,.epub}

replace "free/" "free/files/" -- $filename

#replace "?intcmp=il-data-free-lp-lgen_free_reports_page" "" -- $filename

extension='epub mobi pdf'

for ext in $extension
do
    sed s/csp/$ext/g $filename > $filename.$ext.txt
done

#sed 's/csp/pdf/g' $filename >  $filename.pdf.txt
#sed 's/csp/mobi/g' $filename > $filename.mobi.txt
#sed 's/csp/epub/g' $filename > $filename.epub.txt


#this part to download all the files listed in  filename.*

for i in $filename.* 
do
    wget -c -i  "$i"    # use "" to avoid the url containing spaces
done
