#!/bin/bash
path1=$(pwd)
if [ -z "$1" ]
then
    pathroot="./"
else 
    pathroot=$1
fi
cd "$pathroot"
path2=$(basename "$(pwd)")
cd ..
find "$path2" -type d -exec mkdir compress{} \;
find "$path2" -type f -not -iname "*.pdf" -exec cp {} compress{} \;
find "$path2" -iname "*.pdf" > /tmp/compressPDF
IFS=$'\n'
for var in $(cat /tmp/compressPDF)
    do
        #var1=$(echo $var | sed 's/.pdf/1.pdf/'  )
        echo $var
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="compress$var" "$var" &
        pid=$!
        spin='-\|/'
        i=0
        while kill -0 $pid 2>/dev/null
        do
           i=$(( (i+1) %4 ))
           printf "\r${spin:$i:1}"
           sleep .1
        done
    done
rm /tmp/compressPDF 
cd $path1
