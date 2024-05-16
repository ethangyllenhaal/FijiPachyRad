#!/bin/bash

#SBATCH --job-name=repeat
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=48:00:00
#SBATCH --partition=condo
#SBATCH --output=_repeat_out_%j
#SBATCH --error=_repeat_error_%j
#SBATCH --mail-user=name@email.edu

module load miniconda3
source activate repeat-env

cd $SLURM_SUBMIT_DIR
dir=$SLURM_SUBMIT_DIR

RepeatMasker -pa 32 -xsmall -species "zebra finch" \
    -dir $dir/repeatmask/Pachycephala_vitiensis_finch \
    $dir/pachy_pseudochrom_ref_shortname.fasta
	