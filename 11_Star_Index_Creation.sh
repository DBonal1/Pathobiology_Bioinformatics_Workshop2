#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 12
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=120G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_STAR_Index_Creation_%j.out

mkdir /users/USERNAME/scratch/Workshop2/genome/Star_Index_Hs_GRCh38_150bp
cd /users/USERNAME/scratch/Workshop2/genome/Star_Index_Hs_GRCh38_150bp

##### Unzip the primary assembly file
gunzip /users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz   
##### Unzip the primary annotation file
gunzip /users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.109.gtf.gz   

# Load the STAR module
module load  star/2.6.1b   #### most recent version on oscar

# Define the paths to the genome assembly fasta file and the annotation file
genome=/users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.dna.primary_assembly.fa    #### your primary assembly
annotation=/users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.109.gtf  #### transcript annotation file

# Define the output directory for the STAR index
output_dir=/users/dbonal/scratch/Workshop2/genome/Star_Index_Hs_GRCh38_150bp

# Create the STAR index
STAR --runThreadN 11 --runMode genomeGenerate --genomeDir $output_dir --genomeFastaFiles $genome --sjdbGTFfile $annotation --sjdbOverhang 149

######## --runThreadN  number of threads used
#### --runMode    creating a genome index
####--genomeDir  where will file product go
###### --genomeFastaFiles   your primary assembly
##### --sjdbGTFfile  transcript annotation file
####  --sjdbOverhang  this is how big your reads you will be providing minus 1.  so if you have 150bp paired end you should set this to 149

#################save space and rezip your files
gzip /users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.dna.primary_assembly.fa  
gzip /users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.109.gtf

echo "Great Job!!!"    ##### Random Comment Added
