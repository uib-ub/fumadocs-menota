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
#condCopyGroup $content/handbok/handbok_2-0/graphics/ch6 "*" public/images/hb2/ch6
condCopyGroup $content/handbok/handbok_2-0/graphics/ch7 "*" public/images/hb2/ch7
condCopyGroup $content/handbok/handbok_2-0/graphics/editors "*" public/images/hb2/editors
condCopyGroup $content/handbok/handbok_2-0/graphics/header "*" public/images/hb2/header
condCopyGroup $content/handbok/handbok_2-0/graphics/stylesheets "*" public/images/hb2/stylesheets
condCopyGroup $content/handbok/handbok_3/graphics/ch2 "*" public/images/hb3/ch2
condCopyGroup $content/handbok/handbok_3/graphics/ch3 *.jpg public/images/hb3/ch3
#condCopyGroup $content/handbok/handbok_3/graphics/ch4 *.jpg public/images/hb3/ch4
condCopyGroup $content/handbok/handbok_3/graphics/ch5 *.gif public/images/hb3/ch5
condCopyGroup $content/handbok/handbok_3/graphics/ch5 *.jpg public/images/hb3/ch5
condCopyGroup $content/handbok/handbok_3/graphics/ch5 *.png public/images/hb3/ch5
#condCopyGroup $content/handbok/handbok_3/graphics/ch7 *.jpg public/images/hb3/ch7
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

condCopy $content/graphics/Annotert-setning-KGS-2.png public/images
condCopy $content/graphics/danmark.gif public/images
condCopy $content/graphics/EAE-logos.jpg public/images
condCopy $content/graphics/EAE-title-page-3.jpg public/images
condCopy $content/graphics/Eirikur-Kristjansson-KGS-annotasjon.jpg public/images
condCopy $content/graphics/Fartein-Overland-KGS-annotasjon.jpg public/images
condCopy $content/graphics/greenarrow.gif public/images
condCopy $content/graphics/HolmPerg-4-fol-11v,7-17.jpg public/images
condCopy $content/graphics/IngvilBudalYouTube2018.png public/images
condCopy $content/graphics/island.gif public/images
condCopy $content/graphics/Juliane-Tiemann-KGS-annoterer.jpg public/images
condCopy $content/graphics/MENOTAbanner.gif public/images
condCopy $content/graphics/Menota-banner.gif public/images
condCopy $content/graphics/Menota-banner-3.gif public/images
condCopy $content/graphics/Menota-beer-2022-08-19.jpg public/images
condCopy $content/graphics/Menota-dinner-2022-08-19.jpg public/images
condCopy $content/graphics/Menota-meeting-2022-08-19.jpg public/images
condCopy $content/graphics/Menota-meeting-zoom-2022-08-19.jpg public/images
condCopy $content/graphics/norge.gif public/images
condCopy $content/graphics/N-initial.gif public/images
condCopy $content/graphics/Omslag-AM-132-fol.png public/images
condCopy $content/graphics/oversettelse-logo.gif public/images
condCopy $content/graphics/Paola-Peratello-demonstrerer-koding.jpg public/images
condCopy $content/graphics/pil.gif public/images
condCopy $content/graphics/raudpil.gif public/images
condCopy $content/graphics/redarrow.gif public/images
condCopy $content/graphics/Reykjavik-zoom-2020-08-24.png public/images
condCopy $content/graphics/Reykjavik-zoom-2021-08-23.png public/images
condCopy $content/graphics/Rune-Kyrkjebo-fotografi.jpg public/images
condCopy $content/graphics/R-initial.gif public/images
condCopy $content/graphics/sverige.gif public/images
condCopy $content/graphics/S-initial.gif public/images
condCopy $content/graphics/Thorsteinn-Vilhjalmsson-KGS-annotasjon.jpg public/images
condCopy $content/graphics/Uppsala-2016-08-26.jpg public/images
condCopy $content/graphics/Handbook.gif public/images/hb1
condCopy $content/graphics/handbook_1-1.gif public/images/hb1
condCopy $content/graphics/handbook_2-0.gif public/images/hb2

condCopy $content/handbok/handbok_2-0/graphics/ch6/bosupg.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/cona.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/cross.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/d.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/dotkgrdot.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/dotsdot.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/eorum.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/es.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/et.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/frabar.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/frun.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/HakonSsharp.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/hanasup.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/hanbar.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/herscapa.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/hstalllig.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/ihc.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/kbarkbaria.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/kslig.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/kstalllig.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/laus.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/legdotabia.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/masup.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/med.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/mosupbar.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/mrun.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/mrunasup.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/ockur.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/Ottarscapsup.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/pbar.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/pbarbl.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/pflourfat.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/pplig.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/Rognvcolon.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/sra.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/thbar.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/thegrsup.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/thrarm.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/thstalllig.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/varscapdotab.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/ver.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/visuptha.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/vtsupisup.gif public/images/hb2/ch6
condCopy $content/handbok/handbok_2-0/graphics/ch6/xpm.gif public/images/hb2/ch6

condCopy $content/handbok/handbok_3/graphics/ch4/01_leggja.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/02_sidan.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/03_gjof.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/04_hendr.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/05_hafdi.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/06_vattar.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/07_er.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/08_maela.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/09_kona.jpg public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/AM233afol-28v,1-2.gif public/images/hb3/ch4
condCopy $content/handbok/handbok_3/graphics/ch4/AM-619-4to-2v,15-21.jpg public/images/hb3/ch4

condCopy $content/handbok/handbok_3/graphics/ch7/A-1-148r,B,1-9_montage.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-4-4to-3r,11-18.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-45-fol-8va,19-36.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-45-fol-18va,26-38.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-56-4to-1r,5-11.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-65-4to-4v,16-20.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-71-8vo-17r.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-76-8vo-11r,16-22.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-76-8vo-23v,10-17.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-132-4to-1r.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-132-4to-12r,marg-bottom.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-132-4to-29v,marg-bottom.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-147-4to-23v,marg-bottom.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-147-4to-89r,16-24.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-226-fol-96va,2-17.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-322-fol-53r,B,21-28.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-334-fol-1v,A,1-20.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-345-fol-1r.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-345-fol-1v.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-345-fol-27r,marg-bottom-outer.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-350-fol,15r,A,12-15.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-421-12mo-47v-48r.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-421-12mo-71v,detail.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-442-12mo-4v,13-23.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-557-4to-3r,26-30.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-618-4to-37r,B,19-28.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-619-4to-47r,15-29.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-732-b-4to-3r,below-1.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-732-b-4to-8v,above-1.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-733-4to-5v,A,20-21.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-789-4to-2v,11-30.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/AM-795-4to-24v,1-8.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Anatomy.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/GKS-1005-fol-5v,marg-bottom.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/GKS-1005-fol-6v,B,46-50.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/GKS-1154-fol-2v,marg-bottom.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/GKS-1154-fol-5v,15-27.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/GKS-1154-fol-35r,18-32.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/GKS-3274-a-4to-22v.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/GKS-3274-a-4to-250v,9-13.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Hierarchy.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/JS-133-4to-37v,16.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Lbs-781-4to-4v,upper-left-corner.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Lbs-781-4to-6v,26-28.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Lbs-781-4to-17r,marg-bottom.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Lbs-781-4to-46r,upper-left-corner.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Medeltidshandskrift-6-5v,1-7.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Medeltidshandskrift-15-140v,marg-bottom.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Medeltidshandskrift-18-6r,13-16.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/nks-2237-4to-4v,18-24.jpg public/images/hb3/ch7
condCopy $content/handbok/handbok_3/graphics/ch7/Thott-21-4to-5r.jpg public/images/hb3/ch7

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