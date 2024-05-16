# FijiPachyRad
Last updated: 16 May 2024

Repository for scripts and input files used in a study investigating the phylogeographic history of Pachycephala whistlers in Fiji. Everything is in subfolders within a zipped file. If you use something here, please cite us.

This README describes the scripts and data files used for the afforementioned project. The data were collected using Illumina sequencing for RAD-seq libraries, largely following the Stacks reference-based pipeline. Scripts and input data file are in the same folder for a given analysis.

_______________________________
------- Stacks pipeline -------

--------- (01_stacks) ---------
_______________________________

run_pachy_rad.pbs - Torque submission script used to run the pipeline. It was very quick, using only a single 8-core node for <10 hours. Made to run on UNM's Center for Advanced Research Computing's Wheeler cluster. Note that this used the original reference without abbreviated names, annotation was done afterwards with the same pseudochromosome backbone, but without re-reunning the pipeline.

popmaps directory - Directory of population maps used to make subset input files.

_______________________________
----------- Adegenet ----------

-------- (02_adegenet) --------
_______________________________

PachyHybrid_PCA.R - R script for the 2 PCAs in the paper, with the first one walking through the process in detail. The graeffii (yellow-throated) PCA is in Figure 2. The other (all population) PCA is in Figure S1.

pachy_*_75.vcf - 75% complete VCF files for subsets of the data (all yellow-throated and all RAD-seq samples).

_______________________________
------------- sNMF ------------

---------- (03_sNMF) ----------
_______________________________

pachy_snmf.R - R script for the sNMF plot in the paper (Figure 2).

pachy_nosingle_graef75 - 75% complete VCF file without singletons for all yellow-throated.

_______________________________
--------- Pairwise Fst --------

------ (04_pairwise_Fst) ------
_______________________________

pairwise_Fst_vcftools.sh - Shell script used for calculating pairwise Fst between all population using VCFtools. Output used in Table S3. Note that it was run including only the pseudo-Z chromosome or excluding only the pseudo-Z chromosome (the 3rd command line argument). This is "--chr PseudoZ_dnac_ctaeGut3.2.4Z1728613511_REF" or "--not-chr PseudoZ_dnac_ctaeGut3.2.4Z1728613511_REF", respectively.

pops directory - Files used to specify populations.

pachy_full75.vcf - 75% complete VCF file for the full dataset.

_______________________________
------ RAD Phylogenetic -------

--------- (05_phylo) ----------
_______________________________

IQ-TREE Output in Figure 2. SVDQuartets output in Supplement.

pachy_rad77_90.tre - IQ-TREE phylogeny for all samples.

pachy_rad77_90.phylip - Input for IQ-TREE, a 75% complete phylip matrix, generated with Stacks and slight manual modifications (removing comment at the end).

pachy_*_90.nexus - Nexus alignments with taxset info used for SVDQuartets for all taxa and excluding Ovalau.

pachy_*_90_100kquart.nex - Nexus trees output by SVDQuartets (note that "branch times" are support values), generated with above files and 100k evaluated quartets.
_______________________________
----------- Treemix -----------

--------- (06_treemix) --------
_______________________________

run_treemix.sh - Script of TreeMix commands to run, for 6 different migration values, with jackknifing. This can be easily parallelized with GNU parallel, but wasn't needed with this small dataset.

treemix_plot.R - Simple script for plotting TreeMix output, requires plotting functions provided by the developers.

pachy_full90.treemix.gz - Input for treemix, produced by Stacks then gzipped (TreeMix likes gz input).

_______________________________
------------ DSuite -----------

--------- (07_DSuite) ---------
_______________________________

run_D.sh - Shell script used for running Dsuite. The first one is used for the main ABBA/BABA results (Fig 3, Table S4-5), and the second excludes Ovalau to avoid over-estimating gene flow and allow more accurate multiple comparisons. Both had fbranch run, but only the first is presented in Figure S4).

pachy_full90.vcf - Input VCF for the analysis.

topo{\_subset}.nwk pachy_[full/subset] - Topologies and population maps used for main and subset (i.e., no Ovalau) analysis. Note that the popmaps list the outgroup as Outgroup as opposed to a geographic/taxonomic name.

_______________________________
----- FST Manhattan Plots -----

------- (08_manhattan) --------
_______________________________

windowed_fst_vcftools.sh - Wrapper shell script for using vcftools to generate windowed FST between a set of comma separated population pairs. Uses an unfiltered VCF and list of population pairs to be tested, plus a population directory full of population lists.

pachy_full_fst.vcf - Unfiltered VCF used in this analysis. Filtering is done in VCFtools instead of stacks.

rename_fst.sh - Script for converting chromosome names to numbers in fst output for qqman. Numbers are simple integers, so chromosomes 1, 1A, and 1B and 1, 2, and 3. 

fst_pairs - Text file of comma separated pairs tested here.

intervals.list - List of intervals in the reference, used by renaming script.

fst_plot.R - R script for making Manhattan plots with qqman. Uses a function written for qqman users and makes 12 plots (3 main text only, 3 main and supp, 6 supp only; Fig 4 and S5).

pop directory - Directory of population lists used to calculate FST.
_______________________________
-- UCEs Phylogeny and Dating --

---------- (09_UCEs) ----------
_______________________________

NOTE: Phylogenetic analyses were run by MJA (other scripts by EFG). Output in Figure 1.

beast95per_10runs_logcombined.tre - Phylogeny presented in Fig. 1, with PP values.

pachy_fiji36_95per_*_HKYG-mrca.XML - XML files for individual BEAST runs, representing both the run parameters and the alignments used for the analysis.

_______________________________
-- References and annotation --

------- (10_annotation) -------
_______________________________

mask_repeats.slurm - Slurm script for running RepeatMasker. Takes in the pseudochromosome level genome as input.

gemoma.slurm - Slurm script for running gemoma with NCBI annotations as reference (downloaded and renamed prior to script). This used a node with 1TB memory, but it didn't need all of it. Input (pachy_pseudochrom_zfRM.fasta) is from mask_repeats.slurm.

pachy_original_ref.fasta - Reference output by Supernova, input into Satsuma for making pseudochromosomes.

pachy_pseudochrom_ref.fasta - Base pseudochromosome reference, used for running Stacks.

pachy_pseudochrom_ref_shortname.fasta - Reference used as input for repeat masking, removed metadata in chromosome names from Satsuma.

pachy_pseudochrom_zfRM.fasta - Reference used for annotation.
