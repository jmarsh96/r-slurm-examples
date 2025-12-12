#!/bin/bash

#SBATCH --job-name=array_job
#SBATCH --output=logs/array_job_%A_%a.out
#SBATCH --error=logs/array_job_%A_%a.err
#SBATCH --array=1-10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem=1G

# Load the R module (if required by your HPC system)
module load R

# Run the R script with the SLURM task ID
Rscript code/array_job.R