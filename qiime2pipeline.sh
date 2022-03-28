#!/bin/bash
# input: overlapping forward and reverse reads in  2 .fastq.gz files
INIT_PWD=$PWD


# DADA2 - SINGLE & PAIRED

conda activate qiime2-2020.6


# Fali barcode
qiime tools import \
  --type 'SampleData[SequencesWithQuality]' \
  --input-path se-33-manifest \
  --output-path single-end-demux.qza \
  --input-format SingleEndFastqManifestPhred33V2

qiime demux summarize \
  --i-data single-end-demux.qza \
  --o-visualization demux-single-end.qzv

qiime dada2 denoise-single \
  --i-demultiplexed-seqs single-end-demux.qza \
  --p-trim-left 0 \
  --p-trunc-len 147 \
  --o-representative-sequences rep-seqs-dada2-single.qza \
  --o-denoising-stats denoising \
  --o-table table-dada2-single.qza

#qiime dada2 denoise-paired \
#       --i-demultiplexed-seqs demux-paired-end.qza \
#       --o-table table-dada2.qza \
#       --o-representative-sequences rep-seqs-dada2.qza \
#       --p-trim-left-f 0 \
#       --p-trim-left-r 0 \
#       --p-trunc-len-f 150 \
#       --p-trunc-len-r 150

#qiime feature-table summarize \
#  --i-table table-dada2.qza \
#  --o-visualization table.qzv \

#qiime feature-table tabulate-seqs \
#  --i-data rep-seqs-dada2-single.qza \
#  --o-visualization rep-seqs-dada2-single.qzv

#qiime vsearch cluster-features-de-novo \
#      	--i-table table-dada2-single.qza \
#      	--i-sequences rep-seqs-dada2-single.qza \
#      	--o-clustered-table table-dn-90.qza \
#        --o-clustered-sequences rep-seqs-dn-90.qza \
#      	--p-perc-identity 0.90
#
qiime feature-classifier classify-sklearn \
  --i-classifier classifiers/classifier_silva132_99_initial_version_062020.qza   \
  --i-reads rep-seqs-dada2-single.qza \
  --o-classification taxonomy.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

#qiime taxa collapse \
#  --i-table table-dada2-single.qza \
#  --i-taxonomy taxonomy.qza \
#  --p-level 2 \
#  --o-collapsed-table collapsed-table-dada2-single.qza

#qiime feature-table relative-frequency \
#  --i-table collapsed-table-dada2-single.qza \
#  --o-relative-frequency-table rf-table-dada2-single.qza

#  qiime feature-table summarize \
#  --i-table rf-table-dada2-single.qza \
#  --m-sample-metadata-file sample-metadata.tsv \
#  --o-visualization rf-table-dada2-single.qzv

qiime taxa barplot \
  --i-table table-dada2-single.qza \
  --i-taxonomy taxonomy.qza \
  --m-metadata-file ag-gender-metadata.tsv \
  --o-visualization taxa-bar-plots.qzv


cd $INIT_PWD
