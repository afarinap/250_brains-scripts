
%Gives mean within the mask for CONGRUENT minus INCONGRUENT trials
%% NEED TO MULTIPLY OUTPUT BY -1 TO GET INCONGRUENT MINUS CONGRUENT CONTRAST %% 
%% 


allsub   = dir('/exports/fsw/afarina/250_brains/250_brains/PIOP_FIRST_AND_GROUPLEVEL/FirstLevel_piop/*pi*');
Pathstem = '/exports/fsw/afarina/250_brains/250_brains/PIOP_FIRST_AND_GROUPLEVEL/FirstLevel_piop/';


% creates bash_script to use in Shark
mean_LEFT_DLPFC_CONG_min_INCONG_script = {sprintf(['#!/bin/bash\n#$ -S /bin/bash\n#$ -q all.q\n#$ -N mean_LEFT_DLPFC_CONG_min_INCONG_script\n#$ -pe BWA 2\n'...
    '#$ -l h_vmem=3g\n#$ -cwd\n#$ -j Y\n#$ -V\n module load fsl/5.0.10-shark\n'])};

count = 1;
for s = 1:length(allsub)
    % finds if strooptask has been run for that subject
    stroopdir = dir([Pathstem allsub(s).name, filesep, '*stroop.feat*']);
    if ~isempty(stroopdir)
        count = count+1;
        mean_LEFT_DLPFC_CONG_min_INCONG_script{count} = ['fslstats ', Pathstem allsub(s).name , filesep, stroopdir.name filesep, 'reg_standard/andrea_tstat3.nii.gz',... 
            ' -k /exports/fsw/afarina/250_brains/Masks/LEFT_DLPFC_SEED.nii.gz -m ',...  
            '> ', Pathstem allsub(s).name , filesep, stroopdir.name filesep, 'reg_standard/mean_tstat_LEFT_DLPFC_CONG_min_INCONG.txt' ];
    end
end

% writing the entire bash script to a file so that we can do it on the
% Shark 
fid = fopen(sprintf('/exports/fsw/afarina/250_brains/Bash_scripts/mean_LEFT_DLPFC_CONG_min_INCONG_script.sh'), 'w');
for t = 1:length(mean_LEFT_DLPFC_CONG_min_INCONG_script)
    fprintf(fid,'%s\n',mean_LEFT_DLPFC_CONG_min_INCONG_script{t});
end
fclose(fid);


