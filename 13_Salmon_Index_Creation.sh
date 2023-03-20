#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 12
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_13_SALMON_Index_Creation_%j.out

#Change directory to salmon index file
cd /users/USERNAME/scratch/Workshop2/genome/Salmon_Index_Hs_GRCh38

# Load modules
module load salmon/1.3.0   #### most recent version on oscar
module load boost/1.69
module load gcc/8.3

##### Create variable of of genome/transcriptome file that is unzipped
gentrome=Homo_sapiens_GRCh38_gentrome.fa.gz

##Create Variable for the decoy file
decoy=decoys.txt

# Define the output directory for the Salmon index
output_dir=/users/USERNAME/scratch/Workshop2/genome/Salmon_Index_Hs_GRCh38

# Create the Salmon index
salmon index -t $gentrome -d $decoy -p 12 -i $output_dir --gencode
salmon index 

echo "Great Job!!!"


 


echo "Great Job!!!"    ##### Random Comment Added
