% Change file names

allsub   = dir('/exports/fsw/afarina/250_brains/250_brains/PIOP_FIRST_AND_GROUPLEVEL/FirstLevel_piop/*pi*');
Pathstem = '/exports/fsw/afarina/250_brains/250_brains/PIOP_FIRST_AND_GROUPLEVEL/FirstLevel_piop/';


for s = 1:length(allsub)
    % finds if strooptask has been run for that subject
    stroopdir = dir([Pathstem allsub(s).name, filesep, '*stroop.feat*']);
    if ~isempty(stroopdir)
       str_short = strcat([Pathstem allsub(s).name , filesep, stroopdir.name filesep, 'reg_standard/mean_tstat_ACC_INC_min_CONG.txt '...
           Pathstem allsub(s).name , filesep, stroopdir.name, filesep, 'reg_standard/mean_tstat_ACC_CONG_min_INCONG.txt']);
       
       eval(sprintf('movefile %s',str_short));
       % normally can just use movefile but for some reason it wasn't
       % working, so we used strcat and eval instead
           
    end
end


