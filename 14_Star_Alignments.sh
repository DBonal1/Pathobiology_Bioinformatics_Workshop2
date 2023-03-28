#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 18
# Defines the length time for job to run (t)
#SBATCH -t 24:00:00
# Specifies memory to allocate
#SBATCH --mem=120G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_14_STAR_Alignment_%j.out

# Load the STAR module
module load  star/2.6.1b   #### most recent version on oscar
module load bedtools/2.26.0 

### Make directory and subfolders for storage of STAR Alignment files
mkdir /users/USERNAME/scratch/Workshop2/STAR_Alignment_Output
mkdir /users/USERNAME/scratch/Workshop2/STAR_Alignment_Output/BAM_Files

### Path to Star index
STAR_INDEX=/users/USERNAME/scratch/Workshop2/genome/Star_Index_Hs_GRCh38_150bp 
#### Path to folder containing the fastqs you will align
path_trim_fq=/users/USERNAME/scratch/Workshop2/Trimmed_fastqs  
### Path to Star Alignment outputs
path_STAR_Alignment=/users/USERNAME/scratch/Workshop2/STAR_Alignment_Output 
### Path to Bam File output
BAM_DIR=/users/USERNAME/scratch/Workshop2/STAR_Alignment_Output/BAM_Files  

# Align reads with STAR
#### A loop which will align one sample pair at a time 
for prefix in SRR23819063 SRR23819064 SRR23819065 SRR23819072 SRR23819073 SRR23819074 
do

fq1=$path_trim_fq/${prefix}-trimmed-pair1.fastq.gz
fq2=$path_trim_fq/${prefix}-trimmed-pair2.fastq.gz

STAR \
    --runThreadN 12 \
    --readFilesCommand zcat \
    --genomeDir $STAR_INDEX \
    --readFilesIn $fq1 $fq2 \
    --outTmpDir $path_STAR_Alignment/tempdir${base} \
    --outFileNamePrefix $path_STAR_Alignment/${prefix}_ \
    --outSAMtype BAM SortedByCoordinate \
    --twopassMode Basic

done

echo "Great Job!!!"    ##### Random Comment Added
