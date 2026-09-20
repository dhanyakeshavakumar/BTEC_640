#!/bin/bash
#
# Keshavakumar_download_Chr.21.sh
#
# ==================================================
# Author Dhanya Keshava Kumar
#--------------------------------------------------- 
#version 1 september 2026
# 
# Description:
#  Retreive specific data/information from a sequence file downloaded from NCBI
#       1. Make and change directories for btec_640 and class_exercises following the best practices (mkdir, cd, pwd)
#       2. Make directory in class_exercises for sept_14 and make directories for input_file and analysis
#       3. Download and extract the human genome annotation (gtf file, the whole genome, all chromosomes). (curl -o, gunzip)
#       4. Extract only the information for chromosome 21. (grep, awk)
#       5. Extract the gene names and accession numbers on chromosome 21. (grep)
#       6. Randomly select 20 genes and download their actual sequences from NCBI, in a single loop. 
#       7. Create and document the script.
#
# loop script usage: 
# while read -r gene accession
#do
    #curl -o "${gene}.fasta" "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=${accession}&rettype=fasta&retmode=text"

# done < 10_genes.txt
#
#
# Required input files (input_files)
#   The downloaded chromosome 21 file from NCBI - hg38.ncbiRefSeq.gtf.gz extracted into gtf file - hg38.ncbiRefSeq.gtf
#
#
#  Make and change working directories
mkdir -p btec_640 #make new directory if does not exist
cd btec_640/class_exercises #change directory
mkdir -p 14_sept #make directory
mkdir -p 14_sept/input_data #make directory for input data
mkdir -p 14_sept/analysis #make directory for analysis
cd sept_14/input_data/ #move into the input data directory

#  Download the chromosome 21 file from NCBI
  curl -o hg38.ncbiRefSeq.gtf.gz "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.ncbiRefSeq.gtf.gz" 
  # Download NCBI file with curl 

  # Unzip the file downloaded
  gunzip hg38.ncbiRefSeq.gtf.gz # Unzip thw data into a gtf file

  # soft link of the unzipped file
  ln -s ../input_data/hg38.ncbiRefSeq.gtf #making a soft link of the unzipped file
   
 # Extract the names and accession numbers from all the protein-coding genes of chromosome 21 in humans
  grep "chr21" hg38.ncbiRefSeq.gtf #Extract all lines that contains chr21 
 # To count line count for a GTF file
  grep -c "chr21" hg38.ncbiRefSeq.gtf 
# To chr21 into a new file 
  grep "chr21" hg38.ncbiRefSeq.gtf > chr21.gtf #to save it in a new file named: **chr21.gtf**
  # Extract only the gene name and accession numbers for protein-coding genes.
  grep "NM_" chr21.gtf > refseq_chr21.gtf

  # To filter the fields/columns in the gtf files 
  awk -F '\t' '{print $9}' refseq_chr21.gtf | head
  #awk -F'DELIMITER' 'CONDITION{FIELDS}' FILENAME `awk` is for pattern scanning and text processing. It processes text line-by-line, breaks each line into columns. It reads a file **one line at a time** and applies your condition to every line. `-F` is a flag that sets the delimiter used to split each line into fields. Default is whitespace; here our file is tab-separated, so `-F'\t'`. `CONDITION` is checked on every line. If it's true, the line prints. FIELDS are referred to as `$1`, `$2`, `$3`... (`$1` = first column, etc.)
  awk -F '\t' '{print $9}' refseq_chr21.gtf | awk -F '"' '{print $2, $4}' | head # we are printing just columns 2 and 4 from filtering using ""
  awk -F '\t' '{print $9}' refseq_chr21.gtf  | awk -F'"' '!seen[$2]++ {print $2, $4}' refseq_chr21.gtf > gene_accession.txt #keep only first occurence (largest file)
  
  #Check the data is selected properly
  wc -l gene_accession.txt
head gene_accession.txt
 
 # Download the sequence of 10 genes.
 #Let's pick the first 10 genes to get their corresponding fasta sequences. For this we will use `head`
 head -n 10 gene_accession.txt > 10_genes.txt
cat 10_genes.txt
#To loop over the gene list and download each one

# `if [ CONDITION ]` checks something. Note the required spaces inside the brackets: `[ CONDITION ]`, not `[CONDITION]`.
# `then` starts what happens if the condition is true.
# `else` (optional) is what happens if it's false.
# `fi` closes the `if` block (it's "if" spelled backwards — bash's convention for closing block keywords).
# `[ -s "$file" ]` is a specific, common condition: "does this file exist **and** is it non-empty" — exactly what you want to check right after a download.
#
#Full loop
while read -r gene accession
do
    curl -o "${gene}.fasta" "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=${accession}&rettype=fasta&retmode=text"

done < 10_genes.txt
#Check the results
ls -l *.fasta #list the line on my fasta





