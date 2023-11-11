#!/bin/bash
# Usage: bash pdf_font_clear.sh <dirctory>
# Refer to: https://blog.leiy.me/post/ensure-pdf-fonts-are-embedded/

DIRECTORY=$1

# brew install poppler

function traverse() {
    # for file in "$1"/*
    # do
    #     if [ ! -d "${file}" ] ; then

    #         echo "${file} is a file"
    #     else
    #         echo "entering recursion with: ${file}"
    #         traverse "${file}"
    #     fi
    # done
    find $1 -print0 | while IFS= read -r -d '' file; do
        if [[ $file == *.pdf ]]; then
            # check whether a pdf file contains Type 3 fonts
            ret=$(pdffonts $file)
            if [[ $ret =~ .*"Type 3".* ]]; then
                echo "[Invalid] $file"
                # draw the plot as a pure vector image, with text 
                # rendered into vector shapes. This process is called “outlining”
                gs -o output.pdf -dNoOutputFonts -sDEVICE=pdfwrite $file
                mv output.pdf $file
            else
                echo "[OK] $file"
            fi
        fi
    done
}

traverse $DIRECTORY
