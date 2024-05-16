##########
# By: Ethan Gyllenhaal
# Updated 28Feb2024
#
# R script used for generating PCAs for 2 subsets of Fiji Whistlers.
# Makes each PCA used in the paper, not that modifications were made in illustrator
# Then has one section for each relevant PCA.
# Per-section process described in the first section, but not the second.
# Note that PDFs were made with the export tab then labels were moved in illustrator.
# Colors were also added manually in illustrator for the supplemental (second) PCA.
########

# load packages

library("adegenet")
library("ade4")
library("vcfR")
library("scales")
library("parallel")
library("viridis")
library("wesanderson")
library("RColorBrewer")
setwd('/path/to/directory')


### graeffii (yellow-throated) only, fig 2
# set color scheme
BlackYellow <- colorRampPalette(c("yellow2", "black"))

# read in VCF
graeffii75_vcf <- read.vcfR("pachy_graeffii75.vcf")
# convert to genlight
graeffii75_gl <- vcfR2genlight(graeffii75_vcf)
# assign pops (now I do this by reading in a CSV matching vcf order)
pop(graeffii75_gl) <- c("5Ovalau", "5Ovalau", "5Ovalau", "5Ovalau", "5Ovalau", "5Ovalau", "5Ovalau", "1VitiS", "1VitiS", "2VitiN", "2VitiN", "3VanuaW", "3VanuaW", "3VanuaW", "3VanuaW", "3VanuaW", "3VanuaW", "3VanuaW", "4VanuaC", "4VanuaC", "4VanuaC", "4VanuaC", "4VanuaC", "4VanuaC", "4VanuaC", "4VanuaC", "7VanuaE", "7VanuaE", "7VanuaE", "7VanuaE", "7VanuaE", "7VanuaE", "7VanuaE", "7VanuaE", "7VanuaE", "6Kioa", "6Kioa", "6Kioa", "6Kioa", "6Kioa", "6Kioa", "6Kioa", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "8Rabi", "9Taveuni", "9Taveuni", "9Taveuni", "9Taveuni", "9Taveuni", "9Taveuni", "9Taveuni")
# run the PCA
graeffii75_pca <- glPca(graeffii75_gl, n.cores=4, nf=4)
# make labeled plot for optional troubleshooting
scatter(graeffii75_pca, cex=.25)
# make PCA for figure production
s.class(graeffii75_pca$scores[,1:2], pop(graeffii75_gl), col=BlackYellow(12), clab=1, cell=2.5)
# make barplot to assess PCA weights
barplot(graeffii75_pca$eig/sum(graeffii75_pca$eig), main="eigenvalues", col=heat.colors(length(graeffii75_pca$eig)))


### All taxa (Fig S1)
full75_vcf <- read.vcfR("pachy_full75.vcf")
full75_gl <- vcfR2genlight(full75_vcf)
pop(full75_gl) <- c("5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "5graeffii", "1SantaCruz", "1SantaCruz", "1SantaCruz", "4Kadavu", "4Kadavu", "4Kadavu", "4Kadavu", "4Kadavu", "2Ogea", "2Ogea", "2Ogea", "2Ogea", "2Ogea", "2Ogea", "2Ogea", "2Ogea", "3Vuagava")
full75_pca <- glPca(full75_gl, n.cores=4, nf=4)
scatter(full75_pca, cex=.25)
s.class(full75_pca$scores[,1:2], pop(full75_gl), col=viridis(5,begin=.2,end=.8), clab=1, cell=2.5, cpoint=2)
barplot(full75_pca$eig/sum(full75_pca$eig), main="eigenvalues", col=heat.colors(length(full75_pca$eig)))
