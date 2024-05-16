# Load in additional tools for sNMF
source("http://membres-timc.imag.fr/Olivier.Francois/Conversion.R")
source("http://membres-timc.imag.fr/Olivier.Francois/POPSutilities.R")
# Load main library, LEA
library(LEA)
library("RColorBrewer")
library(viridis)
setwd('/path/to/directory')

# make color palette
BlackYellow <- colorRampPalette(c("yellow", "black"))

# Plotting function used to plot sNMF output.
# Input is sNMF object, the k value, and optionally an array of colors (has default of 10).
plot_sNMF <- function(input, k_val, colors = BlackYellow(k_val+1)){
  # picks best run best on cross entropy
  best_run <- which.min(cross.entropy(input, K = k_val))
  # makes q matrix of ancestry coeffs
  q_matrix <- Q(input, K = k_val, run = best_run)
  # plots the output, space makes blank between indivs
  barplot(t(q_matrix), col = colors, border = NA, space = 0.25, xlab = "Individuals", ylab = "Admixture coefficients", horiz=FALSE)
}
# converts VCF to geno format (for some datasets I need to do this with another script)
vcf2geno("pachy_nosingle_graef75.vcf", output = "C:/Documents/Projects/PachyHybrid/sNMF/graef.geno")

# run sNMF, note the number of reps, alpha parameter, and k values are set here
graef_snmf = snmf("C:/Documents/Projects/PachyHybrid/sNMF/graef.geno", ploidy=2, 
                   K = 1:6, alpha = 10, project = "new", entropy = T, repetitions = 50)

# make line plot of cross entropy criterion (minimum tends to be at k=2, but k=3 lower for some runs)
plot(graef_snmf, cex = 1.2, col = "lightblue", pch = 19)

# plots different K values, 2-5 used in paper
par(mfrow=c(4,1), mar=c(0,2,1.5,0), oma=c(1,2,1,0))
plot_sNMF(graef_snmf, 2, c("yellow2", "#000000"))
plot_sNMF(graef_snmf, 3, c("yellow2", "#7F7F00", "#000000"))
plot_sNMF(graef_snmf, 4, c("#000000", "#AAAA00", "#555500", "yellow2"))
plot_sNMF(graef_snmf, 5, c("yellow2", "#7F7F00", "#BFBF00", "#3F3F00", "#000000"))
plot_sNMF(graef_snmf, 6)

