#! /bin/bash

#Warning! Useless script - linux can't change file creation time

if [ -z "$1" ]
    then
        echo "Argument with target path required"
        exit 22
fi

if [ ! -d "$1" ];
    then
        echo "Target path not exists"
        exit 2
fi

shopt -s globstar
for file in "$1"/**
do
    randomtime=$(echo "$RANDOM * $RANDOM * $RANDOM / 1000" | bc -l)
    echo $file
    date -d @$randomtime
    touch -d @$randomtime -c -a -m "$file"
done