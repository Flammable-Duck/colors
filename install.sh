#!/bin/bash
FILE=/usr/local/bin/color
nimble build
if test -f "$FILE"; then
    echo "Error! $FILE already exists."
else
    echo "Installing..."
    cp ./color $FILE
    echo "done"

fi
