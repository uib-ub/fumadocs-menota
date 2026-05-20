#!/bin/bash

condCopy () {
    source=$1
    target=$2
    filename=$(basename $source)
    mkdir -p $target
    if [ ! -e "${target}/${filename}" ]; then
        cp "${source}" "${target}"
    fi
}

condCopyGroup () {
    sourceDir=$1
    pattern=$2
    target=$3
    for file in "${sourceDir}"/$pattern; do
        condCopy "${file}" "${target}"
    done
}

content="legacy/content-menota"

# Remove possible artefacts from previous build
rm -rf public/legacy

# Create directories for legacy data
mkdir -p public/legacy/{handbook/v1,documents/{council,depo,editorial-board,statutes}}

# Populate legacy html
echo "Populating '${pwd}/public/legacy' ..."
cp $content/dokumenter/DOK_raad*.html public/legacy/documents/council
cp $content/dokumenter/DOK_depo*.html public/legacy/documents/depo
cp $content/dokumenter/DOK_Referat*.html public/legacy/documents/editorial-board
cp $content/dokumenter/DOK_vedtekter-utkast.html public/legacy/documents/statutes
cp $content/handbok/handbok_1/*.html public/legacy/handbook/v1

# Populate updatable files

## Documents
echo "Populating '${pwd}/public/documents' ..."
condCopyGroup $content/pdf *.pdf public/documents/pdf
rm -f public/documents/pdf/HB2_TitlePage.pdf
rm -f public/documents/pdf/HB3_ch5.pdf
rm -f public/documents/pdf/HB3_TitlePage.pdf
condCopyGroup $content/presentasjoner *.odp public/documents/presentations

## Handbook
echo "Populating '${pwd}/public/handbook' ..."
### 1
condCopy $content/xls/EntityConvTable_1-1.xls public/handbook/v1
### 2
condCopy $content/handbok/handbok_2-0/graphics/editors/oXygen1-full.gif public/handbook/v2/editors
condCopy $content/handbok/handbok_2-0/graphics/editors/textpad1-full.gif public/handbook/v2/editors
condCopyGroup $content/eksempler *.xml public/handbook/v2/samples
condCopy $content/pdf/HB2_TitlePage.pdf public/handbook/v2
condCopy $content/pdf/HB3_ch5.pdf public/handbook/v2
### 3
condCopy $content/pdf/HB3_TitlePage.pdf public/handbook/v3
condCopyGroup $content/handbok/handbok_3/graphics/facsimiles *.jpg public/handbook/v3/samples
condCopyGroup $content/handbok/handbok_3/samplefiles "*" public/handbook/v3/samples
condCopyGroup $content/handbok/handbok_3/documents/samples "*" public/handbook/v3/samples
### 4
condCopyGroup $content/handbok/handbok_4/samplefiles "*" public/handbook/v4/samples
