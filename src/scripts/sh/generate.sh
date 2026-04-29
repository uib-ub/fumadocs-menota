#!/bin/bash

saxon=./lib/java/SaxonHE12-5J/saxon-he-12.5.jar
sourcedir=./legacy
codedir=./src
contentdir=./content

segment="${1:-all}"

compile () {
    xml=$sourcedir/$1
    xsl=$codedir/$2
    out=$contentdir/$3
    params=${@:4}
    java -jar $saxon -t -s:$xml -xsl:$xsl -o:$out $params
}

if [[ $segment == "all" || $segment == "ml" ]]; then
    echo "Compiling news items:"
    for file in $sourcedir/meldinger/*; do
        if [ -f "$file" ]; then
            sourceID=$(basename "$file" .xml)
            if [[ "$sourceID" =~ ^ML_[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
                compile meldinger/${sourceID}.xml scripts/xslt/general.xsl news/${sourceID}.mdx
            fi
        fi
    done
fi

if [[ $segment == "all" || $segment == "hb2" ]]; then
    echo "Compiling handbook v2:"
    for file in $sourcedir/handbok/v2/*; do
        if [[ -f "$file" && "$file" == *.xml ]]; then
            sourceID=$(basename "$file" .xml)
            if [[ "$sourceID" =~ ^HB2_ ]]; then
                compile handbok/v2/${sourceID}.xml scripts/xslt/handbook.xsl handbook/v2/${sourceID}.mdx version="2"
            fi
        fi
    done
    mv $contentdir/handbook/v2/HB2_index.mdx $contentdir/handbook/v2/index.mdx
fi

if [[ $segment == "all" || $segment == "hb3" ]]; then
    echo "Compiling handbook v3:"
    for file in $sourcedir/handbok/v3/*; do
        if [ -f "$file" ]; then
            sourceID=$(basename "$file" .xml)
            if [[ "$sourceID" =~ ^HB3_ ]]; then
                compile handbok/v3/${sourceID}.xml scripts/xslt/handbook.xsl handbook/v3/${sourceID}.mdx version="3"
            fi
        fi
    done
    mv $contentdir/handbook/v3/HB3_index.mdx $contentdir/handbook/v3/index.mdx
fi

if [[ $segment == "all" || $segment == "hb4" ]]; then
    echo "Compiling handbook v4:"
    for file in $sourcedir/handbok/v4/*; do
        if [ -f "$file" ]; then
            sourceID=$(basename "$file" .xml)
            if [[ "$sourceID" =~ ^HB4_ ]]; then
                compile handbok/v4/${sourceID}.xml scripts/xslt/handbook.xsl handbook/v4/${sourceID}.mdx version="4"
            fi
        fi
    done
    mv $contentdir/handbook/v4/HB4_index.mdx $contentdir/handbook/v4/index.mdx
fi

if [[ $segment == "all" || $segment == "rest" ]]; then
    echo "Compiling other content:"
    compile menotec.xml scripts/xslt/general.xsl menotec.en.mdx
fi