#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G


## Load modules required for script commands
module load MultiQC/1.0

#############   directories for obtaining QC results
output=/users/USERNAME/scratch/Workshop2/QC/MultiQC
QC=/users/USERNAME/scratch/Workshop2/QC/*.zip
Trim_QC=/users/USERNAME/scratch/Workshop2/Trimmed_fastqs/*.log

multiqc $QC $Trim_QC -o $output
  #####You can put the paths to multiple folders. This has 2 different paths (path1=FastQC results, path2=STAR Alignment results).  You can add more but just put space between each.
  #####You then need to specify a folder where you want the output to go (i.e. -o /user/.....)
 ###### This will generate a compiled html file of all of your QC files (i.e. FastQC results, alignment results, FeatureCounts results, etc) 
   #### for more info check out      https://multiqc.info/ 


