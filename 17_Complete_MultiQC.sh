#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_17_MultiQC_Complete_%j.out

### Load Modules
module load gcc/8.3  ## Most upto date
module load MultiQC/1.0

## Make directory where you will put complete compiled QC from all steps
mkdir /users/USERNAME/scratch/Workshop2/FINAL_QC

# Set Directory to this compiled QC folder
cd /users/USERNAME/scratch/Workshop2/FINAL_QC

### Create Path to QC folder 
Path_To_QC=/users/USERNAME/scratch/Workshop2/QC
### Create Path to STAR Alignment folder (you will be targeting the Log.final.out files)
Path_To_STAR=/users/USERNAME/scratch/Workshop2/STAR_Alignment_Output
###Create Path to FeatureCount folder (you will be targeting the txt.summary files)
Path_To_STARCounts=/users/USERNAME/scratch/Workshop2/STAR_Alignment_Output/Counts
### Create Path to SALMON Alignment folder
Path_To_SALMON=/users/USERNAME/scratch/Workshop2/Salmon_Alignment_Output
 
multiqc -n multiqc_report_rnaseq $Path_To_QC/*zip \
$Path_To_STAR/*Log.final.out \
$Path_To_STARCounts/*txt.summary \
$Path_To_SALMON/*_quant


echo "Great job!  You have finished performing alignments"

