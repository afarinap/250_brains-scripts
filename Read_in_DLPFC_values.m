%reads in mean DLPFC activation for INCONG minus Congruent trials and writes
%them into a new file with their subID

allsub   = dir('/exports/fsw/afarina/250_brains/250_brains/PIOP_FIRST_AND_GROUPLEVEL/FirstLevel_piop/*pi*');
Pathstem = '/exports/fsw/afarina/250_brains/250_brains/PIOP_FIRST_AND_GROUPLEVEL/FirstLevel_piop/';



for s = 1:length(allsub)
    % finds if strooptask has been run for that subject
    stroopdir = dir([Pathstem allsub(s).name, filesep, '*stroop.feat*']);
    if ~isempty(stroopdir)
        mean_DLPFC(s,2) = dlmread([Pathstem, allsub(s).name, filesep, stroopdir.name, filesep, 'reg_standard/mean_tstat_DLPFC_CONG_min_INCONG.txt']);
        subID = str2num(allsub(s).name(3:end)); %only takes the characters from the 3rd to the end
        mean_DLPFC(s,1) = subID;
    end
end

cd ../250_brains
dlmwrite('mean_DLPFC_cong_min_incong.txt', mean_DLPFC, '\t');
