% Concatenates all subject first level analyses (zstat1.nii.gz) into one 4D file so that we can use
% randomize (instead of FLAME) in FSL after (and then see if what we have
% is significant). We will do a whole brain analysis and using a TPJ mask

subjects = dir(sprintf('/exports/fsw/afarina/250_brains/250_brains/PPI/*pi*'));
mkdir(sprintf('/exports/fsw/afarina/250_brains/250_brains/PPI/LEVEL2/'));
cd(sprintf('/exports/fsw/afarina/250_brains/250_brains/PPI/LEVEL2/'));

reg_zstat = {}; %empty cell array for all subjects' registered zstat1 files

Pathstem = '/exports/fsw/afarina/250_brains/250_brains/PPI/';

count = 0;
for s = 1:length(subjects)
    % finds T1_to_MNI.nii.gz for each subject
    reg_zstat_dir = dir([Pathstem subjects(s).name, filesep, '*PPI.feat*']);
    if ~isempty(reg_zstat_dir) 
        count = count+1;
        reg_zstat{count} = [Pathstem, subjects(s).name, filesep, reg_zstat_dir.name, filesep, 'stats/', 'T1_to_MNI.nii.gz'];
    end
end

% makes all file names into one line
for i = 1:length(reg_zstat)
    if i == 1
        reg_zstat_all = reg_zstat{i}; % the first line of zstat1_all is just the first file
    else
        reg_zstat_all = sprintf('%s %s', reg_zstat_all, reg_zstat{i}); %when i is not 1, it adds the previous lines
    end
end

system(sprintf('fslmerge -t /exports/fsw/afarina/250_brains/250_brains/PPI/LEVEL2/reg_zstats_ACC_incong_min_cong.nii.gz %s', reg_zstat_all));


