#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 18
# Defines the length time for job to run (t)
#SBATCH -t 30:00:00
# Specifies memory to allocate
#SBATCH --mem=24G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_15_SALMON_Alignment_%j.out

### Make Salmon Alignment folders and subfolders
mkdir /users/USERNAME/scratch/Workshop2/Salmon_Alignment_Output/
mkdir /users/USERNAME/scratch/Workshop2/Salmon_Alignment_Output/SAM_BAM

module load salmon/1.3.0  # Most up to date on CCV
module load boost/1.69  # Almost most upto date
module load gcc/8.3  ## Most upto date
module load samtools/1.9

#### Path to folder containing the fastqs you will align
path_trim_fq=/users/USERNAME/scratch/Patho_Bioinfomatics/Trimmed_fastqs
#### Path to SALMON Alignment folder
path_Salmon_Alignment=/users/USERNAME/scratch/Workshop2/Salmon_Alignment_Output
### Path and SALMON Index folder 
path_Salmon_INDEX=/users/USERNAME/scratch/Workshop2/genome/Salmon_Index_Hs_GRCh38 
### Path and SALMON Alignment BAM/SAM folder
path_for_SamFiles=/users/USERNAME/scratch/Workshop2/Salmon_Alignment_Output/SAM_BAM

#### A loop which will align one sample pair at a time
for prefix in SRR23819063 SRR23819064 SRR23819065 SRR23819072 SRR23819073 SRR23819074
do
salmon quant \
-i $path_Salmon_INDEX \
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
samtools view -b -S $path_for_SamFiles/${prefix}.sam > $path_for_SamFiles/${prefix}.bam
#Sort BAM file
samtools sort -@ 4 -T $path_for_SamFiles/${prefix}.sorted.tmp -o $path_for_SamFiles/${prefix}.sorted.bam $path_for_SamFiles/${prefix}.bam
#Index sorted BAM file
samtools index $path_for_SamFiles/${prefix}.sorted.bam

####SAVE SPACE#####
#### Remove the very large SAM files
rm $path_for_SamFiles/${prefix}.sam 
#### Remove unsorted BAM Files
rm $path_for_SamFiles/${prefix}.bam  


done


echo "Great Job!!!"
