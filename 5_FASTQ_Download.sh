#!/bin/bash
# Defines number of cores to use (n)
#SBATCH -n 6
# Defines the length time for job to run (t)
#SBATCH -t 12:00:00
# Specifies memory to allocate
#SBATCH --mem=32G

##########################################################################################
#
# Running Note:
#
# For your first SRA data retrieval on Oscar, you will need to run 
# module load sratoolkit/2.10.5 from the login node (without running a batch script) 
# and then follow the steps below to configure SRA for the first time.
#
# You will receive a message saying "This sra toolkit installation has not been 
# configured: Before continuing, please run: vdb-config --interactive
#
# Run: vdb-config --interactive
#
# Press enter to accept no changes
#
# Press the x key on your keyboard to exit the configuration window, 
# completing configuration (there are no actions besides these needed to configure 
# the tool).
#
# Proceed with submitting the batch script from the directory that you would like 
# to store your raw data in.
#
##########################################################################################

module load sratoolkit/2.10.5

cd /users/USERNAME/scratch/Workshop2/Raw_fastqs  ####Set directory to folder you want fastqs downloaded into
# Download the files each will contain 2 fastq files, forward and reverse
fasterq-dump --split-files SRR23819063
fasterq-dump --split-files SRR23819064
fasterq-dump --split-files SRR23819065
fasterq-dump --split-files SRR23819072
fasterq-dump --split-files SRR23819073
fasterq-dump --split-files SRR23819074


gzip *.fastq