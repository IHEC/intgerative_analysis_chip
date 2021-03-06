#!/bin/bash


ifNotThenWget(){
  fname=$(basename $1)
  if [ ! -f $fname ]; then
    wget $1
  else
    echo "# $fname exists"
  fi
}

ifNotThenWgetAndUntar(){
  fname=$(basename $1)
  if [ ! -f $fname ]; then
    wget $1
    tar xvf $fname 
  else
    echo "# $fname exists"
  fi
}


ifNotThenWget https://github.com/broadinstitute/cromwell/releases/download/34/cromwell-34.jar
chmod +rx cromwell-34.jar

ifNotThenWget http://www.epigenomes.ca/resources/GSCtools/BAM2WIG-1.0.0.jar

ifNotThenWget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/wigToBigWig 
chmod +x ./wigToBigWig


ifNotThenWgetAndUntar https://storage.googleapis.com/encode-pipeline-genome-data/test_genome_database_hg38_chip.tar

ifNotThenWgetAndUntar https://storage.googleapis.com/encode-pipeline-test-samples/encode-chip-seq-pipeline/ENCSR936XTK/ENCSR936XTK_fastq_subsampled.tar


if [[ ${1:-"https"} == "ssh" ]]; then
  echo "using git:ssh"
  git clone ssh://git@github.com/ENCODE-DCC/chip-seq-pipeline2.git
  #git clone ssh://git@github.com/ENCODE-DCC/chip-seq-pipeline-test-data.git
else
  echo "using git:https"
  git clone https://github.com/ENCODE-DCC/chip-seq-pipeline2
  #git clone https://github.com/ENCODE-DCC/chip-seq-pipeline-test-data.git
fi

cd ./chip-seq-pipeline2
git checkout tags/v1.1.4
cd -

wget https://github.com/ENCODE-DCC/chip-seq-pipeline-test-data/archive/v1.1.6.tar.gz
tar xvzf ./v1.1.6.tar.gz 
mv chip-seq-pipeline-test-data-1.1.6 chip-seq-pipeline-test-data

mv chip-seq-pipeline-test-data ./chip-seq-pipeline2/test/test_task

echo "#ok"







