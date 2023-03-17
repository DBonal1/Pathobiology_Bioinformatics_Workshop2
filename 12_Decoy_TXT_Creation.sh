#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G


# Define the paths to the genome assembly fasta file  in zipped format
genome=/users/USERNAME/data/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz    #### your primary assembly ZIPPED
transcriptome=/users/USERNAME/data/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.cdna.all.fa.gz
# Define the output directory for the decoy txt file
decoy_output=/users/USERNAME/data/genome/Salmon_Index_Hs_GRCh38/decoys.txt    
gentrome=/users/USERNAME/data/genome/Salmon_Index_Hs_GRCh38/Homo_sapiens_GRCh38_gentrome.fa

gunzip $transcriptome
# Create Decoys for Salmon
grep "^>" <(gunzip -c $genome) | cut -d " " -f 1 > $decoy_output
sed -i.bak -e 's/>//g' $decoy_output

cat $genome $transcriptome > $gentrome   ### 

gzip $transcriptome ### save space and zip files
gzip $gentrome      ### save space and zip files

echo "Great Job!!!"    ##### Random Comment Added
