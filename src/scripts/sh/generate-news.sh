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

echo "Compiling handbook v3:"
for file in $sourcedir/handbok/v3/*; do
    if [ -f "$file" ]; then
        sourceID=$(basename "$file" .xml)
        if [[ "$sourceID" =~ ^HB3_ ]]; then
            compile handbok/v3/${sourceID}.xml scripts/xslt/handbook3.xsl handbook/v3/${sourceID}.mdx
        fi
    fi
done