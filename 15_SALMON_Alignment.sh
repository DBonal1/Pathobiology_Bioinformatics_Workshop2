#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 30:00:00
# Specifies memory to allocate
#SBATCH --mem=24G


module load salmon/1.3.0  # Most up to date on CCV
module load boost/1.69  # Almost most upto date
module load gcc/8.3  ## Most upto date
module load samtools/1.9

path_trim_fq=/users/USERNAME/scratch/Workshop2/Trimmed_fastqs  #### Path to folder containing the fastqs you will align
path_Salmon_Alignment=/users/USERNAME/scratch/Workshop2/Salmon_Alignment_Output ### Path and folder creation for folder post 
path_for_SamFiles=/users/USERNAME/scratch/Workshop2/Salmon_Alignment_Output/SAM_BAM

#### A loop which will align one sample pair at a time
for prefix in SRR23819063 SRR23819064 SRR23819065 SRR23819072 SRR23819073 SRR23819074
do
salmon quant \
-i /users/USERNAME/data/genome/Salmon_Index_Hs_GRCh38 \
-l IU \
-1 $path_trim_fq/${prefix}-trimmed-pair1.fastq.gz \
-2 $path_trim_fq/${prefix}-trimmed-pair2.fastq.gz \
--writeMappings=$path_for_SamFiles/${prefix}.sam \
--validateMappings \
--no-version-check \
--seqBias \
--gcBias \
-o $path_Salmon_Alignment/${prefix}_transcripts_quant

##### Deal with the very large SAM files that have been created, ie convert to sorted BAM files
samtools view -b -S ${prefix}.sam > $path_for_SamFiles/${prefix}.bam
#Sort BAM file
samtools sort -@ 4 -T $path_for_SamFiles/${prefix}.sorted.tmp -o $path_for_SamFiles/${prefix}.sorted.bam $path_for_SamFiles/${prefix}.bam
#Index sorted BAM file
samtools index $path_for_SamFiles/${prefix}.sorted.bam
rm $path_for_SamFiles/${prefix}.bam  #### Remove unsorted BAM Files
rm $path_for_SamFiles/${prefix}.sam  #### Remove the very large SAM files

done