#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 12
# Defines the length time for job to run (t)
#SBATCH -t 24:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_Create_Directories_%j.out

## Load modules required for script commands,  So this loads the most recent version of FastQC.  
module load skewer/0.2.1

# get our data files
FQ_DIR=/users/USERNAME/scratch/Workshop2/Raw_fastqs  #### Location of raw fastqs
FINAL_DIR=/users/USERNAME/scratch/Workshop2/Trimmed_fastqs  #### Where the trimmed fastqs will go

for base in SRR23819063 SRR23819064 SRR23819065 SRR23819072 SRR23819073 SRR23819074
do
  echo $base

  # define R1 fastq filename
  fq1=$FQ_DIR/${base}_1.fastq.gz

 # define R2 fastq filename
  fq2=$FQ_DIR/${base}_2.fastq.gz

## Run FASTQC 
skewer -m pe -z -q 20 -l 50 -t 6 -o $FINAL_DIR/${base}  $fq1 $fq2  

#### -f type of file i.e. fastq or fasta
#### -m pe  this is telling skewer you are giving it paired end reads
#### -z  compression level of files after, this will use gzip
#### -q minimum quality score cutoff
#### -l minimum fragment lenght after trimming
### The "-o then /user/..." tells the program where to put the output files created by FASTQC 

done
