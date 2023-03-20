#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 12
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=120G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_6_Create_Directories_%j.out


## Change directories to where the fastq files are located, this can be completely different based on where the fastqs are located
cd /users/USERNAME/scratch/Workshop2/Raw_fastqs

## Load modules required for script commands,  So this loads the most recent version of FastQC.  
module load fastqc/0.11.5

output=/users/USERNAME/scratch/Workshop2/QC  #Path to where you want all QC files

## Run FASTQC 
fastqc -o $output -f fastq *.fastq.gz -t 6

### The "-o then /user/..." tells the program where to put the output files created by FASTQC 
####  "-t 4" tell CCV how many files to run at a time
#### "*.fastq.gz" tells program to run program on all files in your current directory (the cd one) that end with .fq.gz 
####  You can change this to *.fastq.gz, *_R1_fastq.gz, etc.  


