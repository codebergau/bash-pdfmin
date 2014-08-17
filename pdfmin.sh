#!/bin/bash

# Checks if SUDO
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        echo "Terminating script"
        exit 1
fi

# Assigns variables
TS=$(date +"%s")
BASE=`pwd -P`

# Checks if requisite directories exist in /root
# if not creates them

if [ ! -d "output" ]; then
        echo -e "Directory $BASE/output/ does not exist"
        echo -e "Creating it now"
        mkdir output
fi

echo "\n"
# Creates an ACL file for each folder in /
for F in *.pdf; do
    if [ -f "${F}" ]; then
        F2=${F#"/"}
        echo "Creating: $BASE/output/$TS-$F2.pdf"
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$BASE/output/$TS-$F2 $F2
    fi
done
echo "\n"
echo "PDF Optimisation Complete"

