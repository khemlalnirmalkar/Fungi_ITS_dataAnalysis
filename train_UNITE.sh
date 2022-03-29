#!/bin/bash

****************** Train classifier for UNITE database for fungi ITS************
Author: Khem
Date: March 29th, 2022 
adapted and for Tips to train the classifier for UNITE
Qiime2 version: qiime2-2022.2

https://john-quensen.com/tutorials/training-the-qiime2-classifier-with-unite-its-reference-sequences/

info from Rob Knight Lab 
/media/scebmeta/SSD/Collaboration/lacti/DraOlivia_LactipanTreatment/qiime2/fastamap_2020.txt

**************** start
download UNITE database e.g. version sh_qiime_release_s_10.05.2021

https://plutof.ut.ee/#/doi/10.15156/BIO/1264763   

tar xzf compressed.file
cd sh_qiime_release_s_10.05.2021/developer

#Fix formatting errors that prevent importation of the reference sequences into QIIME2. There are white spaces that interfere, and possibly some lower case letters that need to be converted to upper case.

awk '/^>/ {print($0)}; /^[^>]/ {print(toupper($0))}' sh_refs_qiime_ver8_99_s_10.05.2021_dev.fasta | tr -d ' ' > sh_refs_qiime_ver8_99_s_10.05.2021_dev_uppercase.fasta

*********************** Import the UNITE reference sequences into QIIME2. (version qiime2-2022.2)

qiime tools import \
--type FeatureData[Sequence] \
--input-path sh_refs_qiime_ver8_99_s_10.05.2021_dev_uppercase.fasta \
--output-path unite-ver8_99_s_10.05.2021.qza


*******************Import the taxonomy file.

qiime tools import \
--type FeatureData[Taxonomy] \
--input-path sh_taxonomy_qiime_ver8_99_s_10.05.2021_dev.txt \
--output-path unite-ver8-taxonomy_99_s_10.05.2021.qza \
--input-format HeaderlessTSVTaxonomyFormat

************** Train the classifier.
qiime feature-classifier fit-classifier-naive-bayes \
--i-reference-reads unite-ver8_99_s_10.05.2021.qza \
--i-reference-taxonomy unite-ver8-taxonomy_99_s_10.05.2021.qza \
--o-classifier unite-ver8-99-classifier-s_10.05.2021.qza.qza



