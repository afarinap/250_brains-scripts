#!/bin/bash
#$ -S /bin/bash
#$ -q all.q
#$ -N Permutations
#$ -pe BWA 2 
#$ -l h_vmem=3g
#$ -cwd
#$ -j Y
#$ -V
#$ -m be

module load fsl/5.0.9-shark

randomise -i /exports/fsw/afarina/250_brains/250_brains/LEVEL2/cross_val/tstat3_first_half_incong_min_cong.nii.gz -o /exports/fsw/afarina/250_brains/250_brains/LEVEL2/cross_val/first_half_stroop_effect_MNI.nii.gz -1 -T -n 5000 -m exports/fsw/afarina/250_brains/Masks/MNI152_T1_2mm_brain_mask.nii.gz
