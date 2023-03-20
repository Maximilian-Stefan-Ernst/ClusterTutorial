#!/bin/bash

#SBATCH --job-name my_first_job
#SBATCH --workdir /mnt/beegfs/home/ernst/ClusterTutorial

#SBATCH --time 0:10:0
#SBATCH --ntasks 20
#SBATCH --cpus-per-task 1
#SBATCH --mem-per-cpu 4GB

#SBATCH --partition test

srun -n 20 Rscript R/sim.R
