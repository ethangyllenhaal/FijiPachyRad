#!/bin/bash

# By: Ethan Gyllenhaal
# Last updated: 29 February 2024
# assumes first argument is an FST output file
# second argument is interval list (like 'cut -f 1 ${reference}.fa.fai > intervals.list')

# set iterator variable
i=1

# for each chromosome, replace that chromosome's name in the output with the iterator #
# NOTE THAT THIS WILL NOT CORRESPOND WITH EXACT CHROM # (e.g., 4A will be 5-7 depending on reference)
while read chrom; do
    sed -i "s/$chrom/$i/g" $1
    i=$((i+1))
done < $2
