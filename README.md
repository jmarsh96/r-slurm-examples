# r-slurm-examples
Simple examples for running R jobs on the HPC using the slurm scheduler

## Binomial Simulation Setup
This repository contains examples of running simulations for a binomial distribution. The simulation involves generating random binomial data for different combinations of parameters:

- `N`: The number of trials (sample size)
- `p`: The probability of success for each trial

For each combination of `N` and `p`, the simulation calculates:
- The mean of the generated data
- The Maximum Likelihood Estimate (MLE) of `p`
- The variance of the generated data

## Approaches to Parallelism
Two different approaches to parallelism are demonstrated in this repository:

### 1. Parallelism Within a Node
The script `parallel_within.R` uses the `mclapply` function from the `parallel` package to parallelize the simulation across multiple cores within a single node. This approach is suitable for smaller-scale simulations where all computations can be performed on a single machine.

Key features:
- Utilizes all available cores on the node (minus one for the main process).
- Results are computed in memory and returned as a single object.

### 2. Distributed Parallelism with SLURM Array Jobs
The script `array_job.R` demonstrates how to distribute the simulation across multiple SLURM array jobs. Each array job processes a subset of the parameter combinations, and the results are saved to separate files.

Key features:
- Distributes the workload across multiple nodes or cores, managed by the SLURM scheduler.
- Each task processes a chunk of the parameter combinations independently.
- Results are saved to individual files for later aggregation.

This approach is ideal for large-scale simulations that require more computational resources than a single node can provide.
