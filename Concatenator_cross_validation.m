% Concatenates half of the subject t-stats into one 4D file so that we can use
% randomize in FSL after (and then use what we find as a mask for other
% half participants)

subjects = dir(sprintf('/exports/fsw/afarina/250_brains/250_brains/PIOP_FIRST_AND_GROUPLEVEL/FirstLevel_piop/*pi*'));
mkdir(sprintf('/exports/fsw/afarina/250_brains/250_brains/LEVEL2/cross_val'));
cd(sprintf('/exports/fsw/afarina/250_brains/250_brains/LEVEL2/cross_val'));

cope3 = {}; %empty cell array for all the andrea_tstat files

Pathstem = '/exports/fsw/afarina/250_brains/250_brains/PIOP_FIRST_AND_GROUPLEVEL/FirstLevel_piop/';

count = 0;
for s = 1:round(length(subjects)/2)
     % finds if strooptask has been run for that subject
    stroopdir = dir([Pathstem subjects(s).name, filesep, '*stroop.feat*']);
    if ~isempty(stroopdir) && strcmp(subjects(s).name, 'pi0064') == 0 % subject 64 had a corrupt file
        count = count+1;
        cope3{count} = [Pathstem, subjects(s).name, filesep, stroopdir.name, filesep, 'reg_standard', filesep, 'andrea_tstat3.nii.gz'];
    end
end

% makes all file names into one line
for i = 1:length(cope3)
    if i == 1
        cope3_all = cope3{i}; % the first line of cope3_all is just the first file
    else
        cope3_all = sprintf('%s %s', cope3_all, cope3{i}); %when i is not 1, it adds the previous lines
    end
end

system(sprintf('fslmerge -t /exports/fsw/afarina/250_brains/250_brains/LEVEL2/cross_val/tstat3_first_half_cong_min_incong.nii.gz %s', cope3_all));


