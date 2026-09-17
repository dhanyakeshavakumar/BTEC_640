### Keshavakumar_download_Chr.21.sh
#
# ==================================================
# Author Dhanya Keshava Kumar
# version 1 september 2026
# 
# Description:
#  Retreive specific data/information from a sequence file downloaded from NCBI
#       1. Make and change directories for btec_640 and class_exercises following the best practices
#       2. Make directory in class_exercises for sept_14 and make directories for input_file and analysis
#       3. Download the human genome annotation (gtf file, the whole genome, all chromosomes).
#       4. Extract only the information for chromosome 21.
#       5. Extract the gene names and accession numbers on chromosome 21.
#       6. Randomly select 20 genes and download their actual sequences from NCBI, in a single loop.
#       7. Create and document the script.
#

# 1. Make and change working directories
mkdir -p btec_640 #make new directory if does not exist
cd btec_640/class_exercises #change directory
mkdir -p 14_sept #make directory
mkdir -p 14_sept/input_data #make directory for input data
mkdir -p 14_sept/analysis #make directory for analysis
cd sept_14/input_data/ #move into the input data directory

#Download the chromosome 21 file from NCBI
  curl -o hg38.ncbiRefSeq.gtf.gz "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/genes/hg38.ncbiRefSeq.gtf.gz" 
  # Download NCBI file with curl 

  #Unzip the file downloaded
  gunzip hg38.ncbiRefSeq.gtf.gz # Unzip thw data into a gtf file

  # soft link of the unzipped file
  ln -s ../input_data/hg38.ncbiRefSeq.gtf #making a soft link of the unzipped file
   
 # 3. Extract the names and accession numbers from all the protein-coding genes of chromosome 21 in humans
  grep "chr21" hg38.ncbiRefSeq.gtf #Extract all lines that contains chr21 
 # To count line count for a GTF file
  grep -c "chr21" hg38.ncbiRefSeq.gtf 
# To chr21 into a new file 
  grep "chr21" hg38.ncbiRefSeq.gtf > chr21.gtf #to save it in a new file named: **chr21.gtf**






