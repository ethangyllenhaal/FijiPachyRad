#!/bin/bash

# Made by Ethan F. Gyllenhaal (egyllenhaal@unm.edu)
# Last updated: 28Feb2024
#
# This is a shell script used as a wrapper for generating a pairwise Fst table for a given set of populations using vcftools.
# Takes one argument (output file), with two other inputs I manually set here (see below).
# One is a VCF file with all relevant samples included. I used one with one random SNP/locus and 100% SNPs only.
# The other input is a directory of text files. Each text files has a population name and names of all samples (names as defined in VCF).
### here "vcftools/pops"
# Takes in 3 variable, the output text file, the input vcf tile, and extra VCFtools options
# in this case, I used the extra options to calculate FST from only Z or all chromosomes except Z
# "--chr PseudoZ_dnac_ctaeGut3.2.4Z1728613511_REF" or "--not-chr PseudoZ_dnac_ctaeGut3.2.4Z1728613511_REF", respectively
#
# Run like: sh pairwise_Fst_vcftools.sh /path/to/output.txt /path/to/input.vcf "extra vcftools options"

# Just to fill space, really only needs to be a tab 
printf "%s\t" "Pops" > $1
# Prints population file names across the top row
for pop in `ls pops`; do 
	printf "%s\t" $pop >> $1 
done
# Adds a newline
echo >> $1 

# Main for loop for making table, nested loop doing every pairwise comparison of populations defined by user.
# Essentially: "For each population, print its name then calculate and print pairwise for each other population."
# Currently relies on internal consistency in order, but could be remedied by adding a population list input file.
for pop1 in `ls pops`; do
	# prints input file name
	printf "%s\t" $pop1 >> $1
	# internal loop for performing pairwise calculation
	for pop2 in `ls pops`; do
		# Only calculates pairwise Fst if populations aren't the same.
		if [ $pop1 != $pop2 ]
		then
			# Uses VCFtools to calculate pairwise Fst. However, the output isn't simply a number, and needs to be processed (this is why the output is used).
			vcftools --vcf $2 --weir-fst-pop pops/$pop1 --weir-fst-pop pops/$pop2 $3 --out fst_temp
			# Locates and outputs the weighted Fst value for the comparison.
			# Note that this doesn't purge this temporary file afterwards.
			grep 'weighted' fst_temp.log | awk '{printf ("%s\t", $7)}' >> $1
		else
			# Prints a "-" as a placeholder for comparisons of the same population.
			# Note that this could be some other value (e.g. nucleotide diversity, Fis) in an analysis.
			printf "%s\t" "-" >> $1
		fi
	done
	# adds a newline after each "pop1" iteration.
	echo >> $1
done

# Remove temp file.
rm fst_temp*
