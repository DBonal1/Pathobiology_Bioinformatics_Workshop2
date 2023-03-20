#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 12
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_Create_Directories_%j.out

#Change directory to salmon index file
cd /users/USERNAME/data/genome/Salmon_Index_Hs_GRCh38

 


# Load modules

module load  salmon/1.3.0   #### most recent version on oscar
module load boost/1.69
module load  gcc/8.3

#Unzip your combined genome/transcriptome file 
gunzip Homo_sapiens_GRCh38_gentrome.fa.gz  

##### create variable of of genome/transcriptome file that is unzipped
gentrome=Homo_sapiens_GRCh38_gentrome.fa 

decoy=/users/USERNAME/data/genome/Salmon_Index_Hs_GRCh38/decoys.txt 

# Define the output directory for the Salmon index
output_dir=/users/USERNAME/data/genome/Salmon_Index_Hs_GRCh38

# Create the Salmon index
salmon index -t $gentrome -d $decoy -p 8 -i $output_dir --gencode 

##### -t  transcript/genome file
##### -d  decoy file
##### -p  number of threads used
##### -i   name of the index that Salmon will create
##### --gencode  ndicates that the genome fasta file is in Gencode format
###### -g   annotation file

#################    save space and rezip your files
gzip gentrome   


echo "Great Job!!!"    ##### Random Comment Added
