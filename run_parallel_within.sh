#!/bin/bash

#SBATCH --job-name=parallel_within   # Job name
#SBATCH --output=slurm_output/parallel_within_%j.out       # Standard output and error log
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks=1                      # Number of MPI tasks (and Julia workers)
#SBATCH --cpus-per-task=2              # Number of CPU cores per task
#SBATCH --time=00:10:00                 # Time limit hrs:min:sec
#SBATCH --mail-type=ALL
#SBATCH --mail-user=j.s.marsh@bham.ac.uk



set -e

module purge; module load bluebear

module load bear-apps/2024a
module load R/4.5.0-gfbf-2024a

Rscript code/parallel_within.R
