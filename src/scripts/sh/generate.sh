#!/bin/bash

saxon=./lib/java/SaxonHE12-5J/saxon-he-12.5.jar
sourcedir=./legacy/content-menota
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
            date="${sourceID/ML_/}"
            if [[ "$sourceID" =~ ^ML_[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
                compile meldinger/${sourceID}.xml scripts/xslt/general.xsl news/${date}.mdx
            fi
        fi
    done
fi

if [[ $segment == "all" || $segment == "hb2" ]]; then
    echo "Compiling handbook v2:"
    for file in $sourcedir/handbok/handbok_2-0/*; do
        if [[ -f "$file" && "$file" == *.xml ]]; then
            sourceID=$(basename "$file" .xml)
            chapter="${sourceID/HB2_/}"
            if [[ "$sourceID" =~ ^HB2_ ]]; then
                compile handbok/handbok_2-0/${sourceID}.xml scripts/xslt/handbook.xsl handbook/v2/${chapter}.mdx version="2"
            fi
        fi
    done
fi

if [[ $segment == "all" || $segment == "hb3" ]]; then
    echo "Compiling handbook v3:"
    for file in $sourcedir/handbok/v3/*; do
        if [ -f "$file" ]; then
            sourceID=$(basename "$file" .xml)
            chapter="${sourceID/HB3_/}"
            if [[ "$sourceID" =~ ^HB3_ ]]; then
                compile handbok/v3/${sourceID}.xml scripts/xslt/handbook.xsl handbook/v3/${chapter}.mdx version="3"
            fi
        fi
    done
fi

if [[ $segment == "all" || $segment == "hb4" ]]; then
    echo "Compiling handbook v4:"
    for file in $sourcedir/handbok/v4/*; do
        if [ -f "$file" ]; then
            sourceID=$(basename "$file" .xml)
            chapter="${sourceID/HB4_/}"
            if [[ "$sourceID" =~ ^HB4_ ]]; then
                compile handbok/v4/${sourceID}.xml scripts/xslt/handbook.xsl handbook/v4/${chapter}.mdx version="4"
            fi
        fi
    done
fi

if [[ $segment == "all" || $segment == "cm" ]]; then
    echo "Compiling council meetings:"
    for file in $sourcedir/dokumenter/DOK_RaadsReferat*.xml; do
        if [ -f "$file" ]; then
            sourceID=$(basename "$file" .xml)
            date="${sourceID/DOK_RaadsReferat/}"
            compile dokumenter/${sourceID}.xml scripts/xslt/general.xsl documents/council/meetings/${date}.mdx
        fi
    done
fi

if [[ $segment == "all" || $segment == "mm" ]]; then
    echo "Compiling council members:"
    for file in $sourcedir/dokumenter/DOK_raad*.xml; do
        if [ -f "$file" ]; then
            sourceID=$(basename "$file" .xml)
            date="${sourceID/DOK_raad/}"
            compile dokumenter/${sourceID}.xml scripts/xslt/general.xsl documents/council/members/${date}.mdx
        fi
    done
fi

if [[ $segment == "all" || $segment == "notice" ]]; then
    echo "Compiling notices of meeting:"
    for file in $sourcedir/innkallinger/*; do
        if [ -f "$file" ]; then
            sourceID=$(basename "$file" .xml)
            date="${sourceID/DOK_[iI]nnkalling/}"
            compile innkallinger/${sourceID}.xml scripts/xslt/general.xsl documents/council/notice/${date}.mdx
        fi
    done
fi

if [[ $segment == "all" || $segment == "rest" ]]; then
    echo "Compiling other content:"
    compile menotec.xml scripts/xslt/general.xsl menotec.en.mdx
    compile DOK_vedtekter-1.xml scripts/xslt/general.xsl documents/statutes/index.mdx
fi