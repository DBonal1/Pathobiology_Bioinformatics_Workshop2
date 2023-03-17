#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 30:00:00
# Specifies memory to allocate
#SBATCH --mem=24G



for prefix in 1 2 3 4 5 6
do
echo 1 + ${prefix}
done