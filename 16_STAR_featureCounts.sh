#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6 
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G
# (OPTIONAL)
# Specifies location for all slurms to be written
#SBATCH -o /users/USERNAME/scratch/Workshop2/slurms/SLURM_16_STAR_FeatureCounts_%j.out

#### Create folder to store all counts tables
mkdir /users/USERNAME/scratch/Workshop2/STAR_Alignment_Output/Counts

# load subread module
module load subread/1.6.2

### Path to Human gft Annotation File
annotation=/users/USERNAME/scratch/Workshop2/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.109.gtf.gz 
### Path to STAR Alignened Bam Files
BAM_DIR=/users/USERNAME/scratch/Workshop2/STAR_Alignment_Output
#### Path to counts output folder
Path_To_Counts=/users/USERNAME/scratch/Workshop2/STAR_Alignment_Output/Counts

for base in SRR23819063 SRR23819064 SRR23819065 SRR23819072 SRR23819073 SRR23819074 
do
  echo $base

  # define the aligned BAM files filename
  aligned_BAM=$BAM_DIR/${base}_Aligned.sortedByCoord.out.bam ####

featureCounts  $aligned_BAM \
-T 5 -a $annotation \
-F GTF  -t exon -g gene_id -o $Path_To_Counts/${base}.txt 

done

echo "done!"
