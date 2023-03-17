#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G

# Load the STAR module
module load  star/2.6.1b   #### most recent version on oscar

# Set variables
STAR_INDEX=/users/USERNAME/data/genome/Star_Index_Hs_GRCh38_150bp  ### Path to Star index
path_trim_fq=/users/USERNAME/scratch/Workshop2/Trimmed_fastqs  #### Path to folder containing the fastqs you will align
path_STAR_Alignment=/users/USERNAME/scratch/Workshop2/STAR_Alignment_Output  ### Path to Star Alignment outputs
BAM_DIR=/users/USERNAME/scratch/Workshop2/STAR_Alignment_Output/BAM_Files  ### Path to Bam File output

# Align reads with STAR
#### A loop which will align one sample pair at a time
for prefix in SRR23819063 SRR23819064 SRR23819065 SRR23819072 SRR23819073 SRR23819074
do

fq1=$FASTQ_DIR/${prefix}-trimmed-pair1.fastq.gz
fq2=$FASTQ_DIR/${prefix}-trimmed-pair2.fastq.gz
STAR \
    --runMode alignReads \
    --runThreadN 30 \
    --readFilesCommand gunzip \
    --genomeLoad  NoSharedMemory \
    --genomeDir $STAR_INDEX \
    --readFilesIn $fq1 $fq2 \
    --outFileNamePrefix $path_STAR_Alignment/${prefix}_ \
    --outSAMtype BAM SortedByCoordinate \
    --quantMode GeneCounts \
    --twopassMode Basic

# Create Sashimi plot input files
bamToBed -i $BAM_DIR/${prefix}_Aligned.sortedByCoord.out.bam \
    | bedItemOverlapCount $STAR_INDEX/chrNameLength.txt stdin \
    > $BAM_DIR/${prefix}.counts

# Alternatively, if you have paired-end data, you can use this command to generate junction counts:
bamToJunctions -i $BAM_DIR/${prefix}_Aligned.sortedByCoord.out.bam \
    -o $BAM_DIR/${prefix}.junc
done

echo "Great Job!!!"    ##### Random Comment Added
