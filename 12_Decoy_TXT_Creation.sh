#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_12_Decoy_txt_Creation_%j.out

#Make directory for SALMON Index
mkdir /users/USRENAME/scratch/Workshop2/genome/Salmon_Index_Hs_GRCh38

#Set directory to the newly created Salmon Index folder
cd /users/USERNAME/scratch/Workshop2/genome/Salmon_Index_Hs_GRCh38

#create path to downloaded genomes and annotation files
path=/users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38

# Create Decoys for Salmon
grep "^>" <(gunzip -c $path/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz) | cut -d " " -f 1 > decoys.txt
sed -i.bak -e 's/>//g' decoys.txt

# Create concatenated transcriptome and genome reference file for index
cat $path/Homo_sapiens.GRCh38.cdna.all.fa.gz $path/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz > Homo_sapiens_GRCh38_gentrome.fa.gz 

echo "Great Job!!!"    ##### Random Comment Added
