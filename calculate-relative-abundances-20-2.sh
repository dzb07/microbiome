#!/bin/bash
# input: overlapping forward and reverse reads in  2 .fastq.gz files
INIT_PWD=$PWD


# DADA2 - SINGLE & PAIRED

source activate qiime2-2020.2
mkdir relative-abundances
mkdir absolute-abundances
qiime tools export --input-path taxa-bar-plots.qzv --output-path absolute-abundances
python relative-abundances.py
