#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_10_GRCh38_PrimeAssmAND_Annot_Download_%j.out

### To create aligner indexes you need a few file. These include a genome and an annotation file
### I like to keep these batch scripts with the files I download as a way of commenting and remembering the exact files I downloaded and from where. 
output=/users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38  #### This will create a folder within your data folder which does not get deleted after time like in scratch.


#### Download the genome file (in fasta format, used in both Star and Salmon)
wget -P $output ftp://ftp.ensembl.org/pub/release-109/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz

#####  Download the annotation file (Needed for Star)
wget -P $output ftp://ftp.ensembl.org/pub/release-109/gtf/homo_sapiens/Homo_sapiens.GRCh38.109.gtf.gz

####   Download Transcriptome  (Needed for Salmon)
wget -P $output ftp://ftp.ensembl.org/pub/release-109/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz


echo "Great Job!!!"    ##### Random Comment Added
