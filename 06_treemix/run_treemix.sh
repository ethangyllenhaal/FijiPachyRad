#!/bin/bash

# runs treemix for 6 different migration edge counts, including jacknifed standard error (-se)
# run naively, without a-prior edges
treemix -i pachy_full100.treemix.gz -root SantaCruz -o ./out/pachy_jk0 -m 0 -se
treemix -i pachy_full100.treemix.gz -root SantaCruz -o ./out/pachy_jk1 -m 1 -se
treemix -i pachy_full100.treemix.gz -root SantaCruz -o ./out/pachy_jk2 -m 2 -se
treemix -i pachy_full100.treemix.gz -root SantaCruz -o ./out/pachy_jk3 -m 3 -se 
treemix -i pachy_full100.treemix.gz -root SantaCruz -o ./out/pachy_jk4 -m 4 -se 
treemix -i pachy_full100.treemix.gz -root SantaCruz -o ./out/pachy_jk5 -m 5 -se
treemix -i pachy_full100.treemix.gz -root SantaCruz -o ./out/pachy_jk6 -m 6 -se
