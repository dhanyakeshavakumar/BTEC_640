# !/bin/bash
#
# hsmith_download_chr21.sh
# Version 1 September 2026
#
# Bash loops and Conditionals: Chromosome 21
# 
# 1. Make a directory for the data within btec_640
cd btec_640/class_exercises
mkdir class_Sep14
cd class_Sep14
mkdir input_data 
cd input_data
#
# 2. Download the chromosome 21 data from NCBI
curl -o hg38.ncbiRefSeq.gtf.gz "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.ncbiRefSeq.gtf.gz"
# This needs to be unzipped
#
# 3. Unzip the file
gunzip hg38.ncbiRefSeq.gtf.gz
#
# 4. Make an analysis directory
cd ../
mkdir analysis
cd analysis
#
# 5. Make a soft link to the input data in analysis
ln -s ../input_data/hg38.ncbiRefSeq.gtf
#
# 6. Extract thhe lines containing chr 21 
# and save them in a new file called chr21.gtf
grep "chr21" hg38.ncbiRefSeq.gtf > chr21.gtf
#
# 7. Extract gene name and accession number from chr21 file
grep "gene_name" chr21.gtf > gene_name.gtf
#
# 8. Extract accession number from chr21 file
grep "NM_" chr21.gtf > refseq_chr21.gtf
#
# 9. Extract just column 9 from accession number file
awk -F '\t' '{print $9}' refseq_chr21.gtf
#
# 10. Split column 9
# split on quote character to get gene name and accession
awk -F '\t' '{print $9}' refseq_chr21.gtf | awk -F '"' '{print $2, $4}' refseq_chr21.gtf > gene_accession.txt
#
# 11. Download sequence of 10 genes from 
head -n 10 gene_accession.txt > 10_genes.txt
cat 10_genes.txt
#
# 12. Loop through 10_genes and use it 
# to download the sequence of each gene from NCBI
while read -r gene accession
do
    curl -o "${gene}.fasta" "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=${accession}&rettype=fasta&retmode=text"

done < 10_genes.txt
#
# CHECK IT

