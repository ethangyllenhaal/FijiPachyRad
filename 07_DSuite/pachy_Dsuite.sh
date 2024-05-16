#!/bin/bash

# By: Ethan Gyllenhaal
# Last updated: 28 February 2024
# Wrapper shell script for all DSuite functions.
# First line per section makes the Dtrios ABBA/BABA output, then Fbranch is calculated, the Fbranch is plotted, and finally files are renamed.

# Full dataset (used for main ABBA/BABA)

/path/to/Dsuite/Build/Dsuite Dtrios pachy_full90.vcf pachy_full -o fbranch/pachy_fb -k 1000 -t topo.nwk
/path/to/Dsuite/Build/Dsuite Fbranch topo.nwk fbranch/pachy_fb_tree.txt -p 0.05 > fbranch_test.txt
/path/to/Dsuite/utils/dtools.py fbranch_test.txt topo.nwk
mv fbranch.png fbranch_full.png

# Dataset with Ovalau removed (used for multiple comparison testing)

/path/to/Dsuite/Build/Dsuite Dtrios pachy_full90.vcf pachy_subset -o fbranch/pachy_fb -k 1000 -t topo_subset.nwk
/path/to/Dsuite/Build/Dsuite Fbranch topo_subset.nwk fbranch/pachy_fb_tree.txt -p 0.05 > fbranch_test.txt
/path/to/Dsuite/utils/dtools.py fbranch_test.txt topo_subset.nwk
mv fbranch.png fbranch_subset.png
