qiime feature-table summarize \
     --i-table table-dada2-single.qza \
     --o-visualization UMtable-dada2O.qzv \
     --m-sample-metadata-file ag-gender-metadata.tsv

qiime feature-table tabulate-seqs \
     --i-data rep-seqs-dada2-single.qza \
     --o-visualization UMrep-seqsO.qzv


qiime phylogeny align-to-tree-mafft-fasttree \
      --i-sequences rep-seqs-dada2-single.qza \
      --o-alignment UMaligned-rep-seqs.qza \
      --o-masked-alignment UMmasked-aligned-rep-seqs.qza \
      --o-tree UMunrooted-tree.qza \
      --o-rooted-tree UMrooted-tree.qza

qiime diversity core-metrics-phylogenetic \
   --i-phylogeny UMrooted-tree.qza \
   --i-table table-dada2-single.qza \
   --p-sampling-depth 500 \
   --m-metadata-file ag-gender-metadata.tsv \
   --output-dir core-metrics-results


alpha-group-significance \
     --i-alpha-diversity core-metrics-results/shannon_vector.qza \
     --m-metadata-file ag-gender-metadata.tsv \
     --o-visualization core-metrics-results/shannon-group-significance.qzv

qiime diversity beta-group-significance \
     --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
     --m-metadata-file ag-gender-metadata.tsv  \
     --m-metadata-column sex \
     --o-visualization core-metrics-results/unweighted-unifrac-sex-significance.qzv \
     --p-pairwise

