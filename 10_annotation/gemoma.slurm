#!/bin/bash

#SBATCH --job-name=anno
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --time=48:00:00
#SBATCH --partition=bigmem-1TB
#SBATCH --output=_anno_out_%j
#SBATCH --error=_anno_error_%j
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=name@email.edu

module load miniconda3
source activate gemoma

cd $SLURM_SUBMIT_DIR
dir=$SLURM_SUBMIT_DIR

GeMoMa -Xmx800G GeMoMaPipeline \
       threads=64 \
       outdir=annotate_quickmask \
       GeMoMa.Score=ReAlign AnnotationFinalizer.r=NO o=true p=false \
       t=~/efg/PachyGenomes/reference/pachy_pseudochrom_zfRM.fasta \
       s=own \
       i=corCor \
       g=ncbi/Corvus_cornix_ref_v5/data/GCF_000738735.5/GCF_000738735.5_ASM73873v5_genomic.fna \
       a=ncbi/Corvus_cornix_ref_v5/data/GCF_000738735.5/genomic.gff \
       s=own \
       i=taeGut \
       g=ncbi/Taeniopygia_guttata_ref/GCF_000151805.1_Taeniopygia_guttata-3.2.4_genomic.fna \
       a=ncbi/Taeniopygia_guttata_ref/GCF_000151805.1_Taeniopygia_guttata-3.2.4_genomic.gff
       
