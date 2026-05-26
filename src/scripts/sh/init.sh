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
schema="legacy/schema-menota"

# Remove possible artefacts from previous build
rm -rf public/legacy
rm -rf public/archive
rm -rf public/old_extensions_files

# Create directories for legacy data
mkdir -p public/legacy/{handbook/v1,documents/{council,depo,editorial-board,statutes}}

# Populate legacy html
echo "Populating '${pwd}/public/legacy' ..."
cp $content/dokumenter/DOK_raad*.html public/legacy/documents/council
cp $content/dokumenter/DOK_depo*.html public/legacy/documents/depo
cp $content/dokumenter/DOK_Referat*.html public/legacy/documents/editorial-board
cp $content/dokumenter/DOK_vedtekter-utkast.html public/legacy/documents/statutes
cp $content/handbok/handbok_1/*.html public/legacy/handbook/v1

## archive
echo "Populating '${pwd}/public/archive' ..."
cp -r $schema/archive public

## old extensions files
echo "Populating '${pwd}/public/old_extensions_files' ..."
cp -r $schema/old_extensions_files public

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

## Helpdesk
echo "Populating '${pwd}/public/helpdesk' ..."
condCopyGroup $content/helpdesk *.pdf public/helpdesk

## Images
echo "Populating '${pwd}/public/images' ..."

condCopyGroup $content/graphics *.gif public/images
condCopyGroup $content/graphics *.jpg public/images
condCopyGroup $content/graphics *.png public/images
condCopyGroup $content/graphics/photos *.jpg public/images/photos
condCopyGroup $content/graphics/images "*" public/images
condCopyGroup $content/handbok/handbok_1/graphics/ch1 "*" public/images/hb1/ch1
condCopyGroup $content/handbok/handbok_1/graphics/ch2 "*" public/images/hb1/ch2
condCopyGroup $content/handbok/handbok_1/graphics/ch3 "*" public/images/hb1/ch3
condCopyGroup $content/handbok/handbok_1/graphics/ch5 "*" public/images/hb1/ch5
condCopyGroup $content/handbok/handbok_1/graphics/ch6 "*" public/images/hb1/ch6
condCopyGroup $content/handbok/handbok_1/graphics/ch7 "*" public/images/hb1/ch7
condCopyGroup $content/handbok/handbok_1/graphics/characters "*" public/images/hb1/characters
condCopyGroup $content/handbok/handbok_1/graphics/editors "*" public/images/hb1/editors
condCopyGroup $content/handbok/handbok_2-0/graphics/ch1 "*" public/images/hb2/ch1
condCopyGroup $content/handbok/handbok_2-0/graphics/ch2 "*" public/images/hb2/ch2
condCopyGroup $content/handbok/handbok_2-0/graphics/ch3 "*" public/images/hb2/ch3
condCopyGroup $content/handbok/handbok_2-0/graphics/ch4 "*" public/images/hb2/ch4
condCopyGroup $content/handbok/handbok_2-0/graphics/ch5 "*" public/images/hb2/ch5
condCopyGroup $content/handbok/handbok_2-0/graphics/ch6 "*" public/images/hb2/ch6
condCopyGroup $content/handbok/handbok_2-0/graphics/ch7 "*" public/images/hb2/ch7
condCopyGroup $content/handbok/handbok_2-0/graphics/editors "*" public/images/hb2/editors
condCopyGroup $content/handbok/handbok_2-0/graphics/header "*" public/images/hb2/header
condCopyGroup $content/handbok/handbok_2-0/graphics/stylesheets "*" public/images/hb2/stylesheets
condCopyGroup $content/handbok/handbok_3/graphics/ch2 "*" public/images/hb3/ch2
condCopyGroup $content/handbok/handbok_3/graphics/ch3 *.jpg public/images/hb3/ch3
condCopyGroup $content/handbok/handbok_3/graphics/ch4 *.gif public/images/hb3/ch4
condCopyGroup $content/handbok/handbok_3/graphics/ch4 *.jpg public/images/hb3/ch4
condCopyGroup $content/handbok/handbok_3/graphics/ch5 *.gif public/images/hb3/ch5
condCopyGroup $content/handbok/handbok_3/graphics/ch5 *.jpg public/images/hb3/ch5
condCopyGroup $content/handbok/handbok_3/graphics/ch5 *.png public/images/hb3/ch5
condCopyGroup $content/handbok/handbok_3/graphics/ch7 *.jpg public/images/hb3/ch7
condCopyGroup $content/handbok/handbok_3/graphics/ch8 "*" public/images/hb3/ch8
condCopyGroup $content/handbok/handbok_3/graphics/ch9 *.jpg public/images/hb3/ch9
condCopyGroup $content/handbok/handbok_3/graphics/ch9 *.png public/images/hb3/ch9
condCopyGroup $content/handbok/handbok_3/graphics/ch10 "*" public/images/hb3/ch10
condCopyGroup $content/handbok/handbok_3/graphics/ch16 "*" public/images/hb3/ch16
condCopyGroup $content/handbok/handbok_3/graphics/characters *.png public/images/hb3/characters
condCopyGroup $content/handbok/handbok_3/graphics/stylesheets *.gif public/images/hb3/stylesheets
condCopyGroup $content/handbok/handbok_3/graphics/stylesheets *.png public/images/hb3/stylesheets
condCopyGroup $content/handbok/handbok_3/graphics/tutorial *.png public/images/hb3/tutorial
condCopyGroup $content/handbok/handbok_4/graphics/ch17 *.jpg public/images/hb4/ch17
condCopyGroup $content/handbok/handbok_4/graphics/ch18 *.jpg public/images/hb4/ch18
condCopyGroup $content/handbok/handbok_4/graphics/MenotaBlitz *.png public/images/hb4/MenotaBlitz

rm -f public/images/Handbook.gif
rm -f public/images/handbook_*
condCopy $content/graphics/Handbook.gif public/images/hb1
condCopy $content/graphics/handbook_1-1.gif public/images/hb1
condCopyGroup $content/graphics handbook_2-0* public/images/hb2
condCopyGroup $content/graphics handbook_3-b.* public/images/hb3
condCopyGroup $content/graphics handbook_4b.* public/images/hb4 
condCopy $content/handbok/handbok_3/graphics/samples/NRA-58-C-3r,B,1-18.jpg public/images/hb3/samples

## Translations
echo "Populating '${pwd}/public/translations' ..."
condCopyGroup $content/translations *.pdf public/translations

## CSS
echo "Populating '${pwd}/public/css' ..."
condCopy $content/css/handbook-web-1.css public/css
condCopy $content/css/menota_base.css public/css
