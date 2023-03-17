#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G

### To create aligner indexes you need a few file. These include a genome and an annotation file
### I like to keep these batch scripts with the files I download as a way of commenting and remembering the exact files I downloaded and from where. 
output=/users/USERNAME/data/genome/Homo_sapiens.GRCh38  #### This will create a folder within your data folder which does not get deleted after time like in scratch.


#### Download the genome file (in fasta format)
wget -P $output ftp://ftp.ensembl.org/pub/release-109/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz

#####  Download the annotation file
wget -P $output ftp://ftp.ensembl.org/pub/release-109/gtf/homo_sapiens/Homo_sapiens.GRCh38.109.gtf.gz

echo "Great Job!!!"    ##### Random Comment Added
