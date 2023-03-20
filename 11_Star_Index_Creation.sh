#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_Create_Directories_%j.out

cd /users/USERNAME/data/genome/Homo_sapiens.GRCh38
gunzip Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz   ##### Unzip the primary assembly file
gunzip Homo_sapiens.GRCh38.109.gtf.gz   ##### Unzip the primary assembly file

# Load the STAR module
module load  star/2.6.1b   #### most recent version on oscar

# Define the paths to the genome assembly fasta file and the annotation file
genome=/users/USERNAME/data/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.dna.primary_assembly.fa    #### your primary assembly
annotation=/users/USERNAME/data/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.109.gtf  #### transcript annotation file

# Define the output directory for the STAR index
mkdir /users/dbonal/scratch/genome/Star_Index_Hs_GRCh38_150bp
output_dir=/users/USERNAME/data/genome/Star_Index_Hs_GRCh38_150bp

# Create the STAR index
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir $output_dir --genomeFastaFiles $genome --sjdbGTFfile $annotation --sjdbOverhang 149

######## --runThreadN  number of threads used
#### --runMode    creating a genome index
####--genomeDir  where will file product go
###### --genomeFastaFiles   your primary assembly
##### --sjdbGTFfile  transcript annotation file
####  --sjdbOverhang  this is how big your reads you will be providing minus 1.  so if you have 150bp paired end you should set this to 149

#################save space and rezip your files
gzip Homo_sapiens.GRCh38.dna.primary_assembly.fa   
gzip Homo_sapiens.GRCh38.109.gtf

echo "Great Job!!!"    ##### Random Comment Added
