# the source is the path to the plotting_funcs.R file
# (see TreemixManual for more info: 
## http://gensoft.pasteur.fr/docs/treemix/1.12/treemix_manual_10_1_2012.pdf)
# the input for "plot_tree" is the path to the folder your treemix output
## with the stem of the output file names (e.g. sympos for me)
# includes the 
source("/path/to/plotting_funcs.R")
setwd('/path/to/directory')

# plot the treemix output (nice and simple!)
par(mfrow=c(1,3), mar=c(0,2,0,0), oma=c(1,2,1,0))

plot_tree("out90/pachy_jk0")
plot_tree("out90/pachy_jk1")
plot_tree("out90/pachy_jk2")
plot_tree("out90/pachy_jk3")
plot_tree("out90/pachy_jk4")
plot_tree("out90/pachy_jk5")
plot_tree("out90/pachy_jk6")
