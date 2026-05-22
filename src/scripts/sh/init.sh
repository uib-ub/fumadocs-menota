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
#condCopyGroup $content/handbok/handbok_3/graphics/samples "*" public/handbook/v3/samples
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
#condCopyGroup $content/handbok/handbok_3/graphics/ch8 "*" public/images/hb3/ch8
#condCopyGroup $content/handbok/handbok_3/graphics/ch9 "*" public/images/hb3/ch9
condCopyGroup $content/handbok/handbok_3/graphics/ch10 "*" public/images/hb3/ch10
condCopyGroup $content/handbok/handbok_3/graphics/ch16 "*" public/images/hb3/ch16
condCopyGroup $content/handbok/handbok_3/graphics/characters *.png public/images/hb3/characters
#condCopyGroup $content/handbok/handbok_3/graphics/stylesheets "*" public/images/hb3/stylesheets
#condCopyGroup $content/handbok/handbok_3/graphics/tutorial *.png public/images/hb3/tutorial
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

condCopy $content/handbok/handbok_3/graphics/ch8/AM-309-fol,42v,10-19.jpg public/images/hb3/ch8
condCopy $content/handbok/handbok_3/graphics/ch8/AM-619-4to-9v,23-30.jpg public/images/hb3/ch8
condCopy $content/handbok/handbok_3/graphics/ch8/AM-619-4to,35v,15-22.jpg public/images/hb3/ch8
condCopy $content/handbok/handbok_3/graphics/ch8/AM-619-4to,62v-63r.png public/images/hb3/ch8
condCopy $content/handbok/handbok_3/graphics/ch8/AM-619-4to-quires-8-10.png public/images/hb3/ch8
condCopy $content/handbok/handbok_3/graphics/ch8/AM-645-4to-51v,32-35.jpg public/images/hb3/ch8
condCopy $content/handbok/handbok_3/graphics/ch8/AM-655-IX-4to,2r,1-5.jpg public/images/hb3/ch8
condCopy $content/handbok/handbok_3/graphics/ch8/NKS-235-g-4to,1r.jpg public/images/hb3/ch8
condCopy $content/handbok/handbok_3/graphics/ch8/XNRA-7-2v-mounted.jpg public/images/hb3/ch8

condCopy $content/handbok/handbok_3/graphics/ch9/AM-242-fol-p1-explanatory-comment.png public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-243-ba-fol-2vB,18-21.png public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-243-ba-fol-5ra,24-26.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-619-4to-8v,23-26.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-619-4to-13v,8-10.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-619-4to-14r,26-30.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-619-4to-26v,7-11.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-619-4to-47r,8-10.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-645-4to-51v,32-35.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-645-4to-55v,5-7.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/AM-677-4to-1v,1-3.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/HolmPerg-34-4to-8r,17-19.jpg public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/Holm-B59-6v,8-10.png public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/NKS-66-8vo-73r,9-13.png public/images/hb3/ch9
condCopy $content/handbok/handbok_3/graphics/ch9/NKS-66-8vo-73v,1-2.png public/images/hb3/ch9

condCopy $content/handbok/handbok_3/graphics/samples/NRA-58-C-3r,B,1-18.jpg public/images/hb3/samples

condCopy $content/handbok/handbok_3/graphics/stylesheets/output-choose.gif public/images/hb3/stylesheets
condCopy $content/handbok/handbok_3/graphics/stylesheets/Oxygen-Apply-transform-scenario.png public/images/hb3/stylesheets
condCopy $content/handbok/handbok_3/graphics/stylesheets/Oxygen-scenario-step2.png public/images/hb3/stylesheets
condCopy $content/handbok/handbok_3/graphics/stylesheets/parameter-choose.gif public/images/hb3/stylesheets

condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-A-Mac.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-A-Windows.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-B-Mac.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-B-Windows.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-C-Mac.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-C-Windows.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-D-Mac.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-D-Windows.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-E-Mac.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-E-Windows.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-F-Mac.png public/images/hb3/tutorial
condCopy $content/handbok/handbok_3/graphics/tutorial/Samples-F-Windows.png public/images/hb3/tutorial