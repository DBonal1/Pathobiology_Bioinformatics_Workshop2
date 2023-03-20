#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6 
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G

# load subread module
module load subread/1.6.2
annotation=/users/dbonal/scratch/Workshop2/genome/Homo_sapiens.GRCh38/Homo_sapiens.GRCh38.109.gtf.gz 
BAM_DIR=/users/dbonal/scratch/Workshop2/STAR_Alignment_Output

mkdir /users/dbonal/scratch/Workshop2/STAR_Alignment_Output/Counts

for base in SRR23819063 SRR23819064 SRR23819065 SRR23819072 SRR23819073 SRR23819074 
do
  echo $base

  # define R1 fastq filename
  fq1=$BAM_DIR/${base}_Aligned.sortedByCoord.out.bam



featureCounts  $fq1 \
-T 5 -a $annotation \
-F GTF  -t exon -g gene_id -o /users/dbonal/scratch/Workshop2/STAR_Alignment_Output/Counts/${base}.txt 

done

echo "done!"







 