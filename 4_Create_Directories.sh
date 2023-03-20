#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 2
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_Create_Directories_%j.out


path2main=/users/USERNAME/scratch/Workshop2 

mkdir $path2main ##### Main folder to store everything
mkdir $path2main/Raw_fastqs  ####location for public FASTQ Download
mkdir $path2main/Trimmed_fastqs
mkdir $path2main/QC
mkdir $path2main/genome
mkdir $path2main/slurms



