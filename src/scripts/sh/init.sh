#!/bin/bash

echo "Populating public/legacy/ ..."

# Remove possible artefacts from previous build
rm -rf public/legacy

# Create directories for legacy data
mkdir -p public/legacy/{handbook/v1,documents/{council,depo,editorial-board,statutes}}

# Populate
cp legacy/content-menota/dokumenter/DOK_raad*.html public/legacy/documents/council
cp legacy/content-menota/dokumenter/DOK_depo*.html public/legacy/documents/depo
cp legacy/content-menota/dokumenter/DOK_Referat*.html public/legacy/documents/editorial-board
cp legacy/content-menota/dokumenter/DOK_vedtekter-utkast.html public/legacy/documents/statutes
cp legacy/content-menota/handbok/handbok_1/*.html public/legacy/handbook/v1