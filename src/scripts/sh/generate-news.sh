#!/bin/bash

saxon=./lib/java/SaxonHE12-5J/saxon-he-12.5.jar
sourcedir=./legacy
codedir=./src
contentdir=./content

compile () {
    xml=$sourcedir/$1
    xsl=$codedir/$2
    out=$contentdir/$3
    java -jar $saxon -t -s:$xml -xsl:$xsl -o:$out
}

echo "Compiling news items:"
for file in $sourcedir/meldinger/*; do
    if [ -f "$file" ]; then
        sourceID=$(basename "$file" .xml)
        if [[ "$sourceID" =~ ^ML_[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            compile meldinger/${sourceID}.xml scripts/xslt/news.xsl news/${sourceID}.mdx
        fi
    fi
done

