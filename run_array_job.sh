#!/bin/bash

#SBATCH --job-name=array_job
#SBATCH --output=logs/array_job_%A_%a.out
#SBATCH --error=logs/array_job_%A_%a.err
#SBATCH --array=1-10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --mem=1G

set -e

module purge; module load bluebear

module load bear-apps/2024a
module load R/4.5.0-gfbf-2024a

Rscript code/array_job.R