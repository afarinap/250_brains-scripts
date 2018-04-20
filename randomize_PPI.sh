#!/bin/bash
#$ -S /bin/bash
#$ -q all.q
#$ -N randomize_PPI
#$ -pe BWA 2
#$ -l h_vmem=3g
#$ -cwd
#$ -j Y
#$ -V

module load fsl/5.0.10-shark

randomise -i /exports/fsw/afarina/250_brains/250_brains/PPI/LEVEL2/reg_zstats_ACC_incong_min_cong.nii.gz -o /exports/fsw/afarina/250_brains/250_brains/PPI/LEVEL2/PPI_ACC_seed_whole_brain.nii.gz -1 -T -n 5000 -m /exports/fsw/afarina/250_brains/Masks/MNI152_T1_2mm_brain_mask.nii.gz

randomise -i /exports/fsw/afarina/250_brains/250_brains/PPI/LEVEL2/reg_zstats_ACC_incong_min_cong.nii.gz -o /exports/fsw/afarina/250_brains/250_brains/PPI/LEVEL2/PPI_ACC_seed_TPJ.nii.gz -1 -T -n 5000 -m /exports/fsw/afarina/250_brains/Masks/PPI_TPJ.nii.gz

