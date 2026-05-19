#!/bin/bash

# Remove possible artefacts from previous build
rm -rf public/legacy/handbook

# Create directories for legacy data
mkdir -p public/legacy/handbook/v1

# Populate
cp legacy/content-menota/handbok/handbok_1/*.html public/legacy/handbook/v1