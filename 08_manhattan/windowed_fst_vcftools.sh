#!/bin/bash

# By: Ethan Gyllenhaal
# Last updated: 29 February 2024
# Wrapper shell script for using vcftools to generate windowed FST between a set of comma separated population pairs.

while IFS=',' read -ra pair; do
	# prints pair name
    echo "${pair[0]}" "${pair[1]}"
	# runs VCFtools for 10kb windows, 75% missing data, and a minor allele count of 2
	# takes in a VCF with all Stacks SNPs, no filters applied in Stacks populations
    vcftools --vcf pachy_full_fst.vcf  --fst-window-size 10000 \
		--weir-fst-pop pops/"${pair[0]}" --weir-fst-pop pops/"${pair[1]}" --remove-filtered-all \
		--min-alleles 2 --max-alleles 2 --mac 2 --max-missing .75
    # for whatever reason I did this instead of setting an output name
	mv out.windowed.weir.fst fst_out/"${pair[0]}"_"${pair[1]}"_weir_10k.fst
	# script to replace chromosome names with numbers (needed for qqMan)
    sh rename_fst.sh fst_out/"${pair[0]}"_"${pair[1]}"_weir_10k.fst intervals.list
done < fst_pairs
