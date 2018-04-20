% Quick and Dirty first level analysis with level_one_PPI.fsf


% this function takes as input the path to where the subjects' raw data is,
% an output path name to distinguish between my different variables, and the
% names of the bfsls that I want to use, and performs a first level
% analysis. The bfsls must be in a cell array in the propper order, which
% is: selection, feedback, selection modulated by variable, feedback
% modulated by variable. This function can be reappropriated for the
% feedback trial by trial design with a few very simple changes to this and
% the reg_dir_copycat function path names. it should be noted that this
% script only conducts the analysis on control runs, not on OT runs.

% things that I searched and destroyed from my template fsf file

% __OUTPUT_DIR__

% __FILTERED_FUNC__ % path to the functional data of each participant

% __EV_1__ %   congruent trials

% __EV_2__ %   incongruent trials



%==========================================================================
% Needs to be altered depending on what I'm testing
subject_data_path = '/exports/fsw/mrgiffin/UG/ToProcess/';

output_path_name = 'QD_Lev1'; % determines the name of the output and the name of the bash_script that's written at the end

% need to change this so that I look into the bfsl directories and get the
% right ones, because I named them all different things
bfsl_names = {'feedback', 'fixation', 'offer_start', 'opponent', 'reward', 'offer'};


%==========================================================================
%%

addpath(genpath('/exports/fsw/mrgiffin/UG/ToProcess/scripts'));

subjects = dir([subject_data_path '/' '*sub*']);


bash_head = sprintf(['#!/bin/bash\n#$ -S /bin/bash\n#$ -q all.q\n#$ -N %s_Lev1\n#$ -pe BWA 8 \n'...
    '#$ -l h_vmem=8g\n#$ -cwd\n#$ -j Y\n#$ -V\n#$ -m be\n'...
    '\nmodule load fsl/5.0.9-shark\n'], output_path_name);

bash_cell{1} = bash_head;
counter = 1; % for the bash cell, starts at 1 because line 1 is already specified above

for ss = 1:length(subjects)
    subject_name = subjects(ss).name;
    fprintf('Processing %s Subject: %s \n', output_path_name, subjects(ss).name)
    
    anat_file = dir([subject_data_path, subject_name, '/anat/*brain.nii.gz']);  % name of structural image
    anat_path = [subject_data_path, subject_name, '/anat/', anat_file.name];    % path to structural image
    
    subjectruns = dir([subject_data_path, filesep, subject_name, '/*run*']);
    
    
    %% Going into each run directory
    for cRuns = 1:length(subjectruns)
        fprintf('Processing run: %s \n', subjectruns(cRuns).name)
        
        counter     = counter + 1; % for making the bash file
        
        mkdir(['/exports/fsw/mrgiffin/UG/QD/', subject_name, '/', subjectruns(cRuns).name])
        
        output_dir  = ['/exports/fsw/mrgiffin/UG/QD/', subject_name, '/', subjectruns(cRuns).name, '/', output_path_name, '.feat'];

        func_file = dir([subject_data_path, subject_name, '/', subjectruns(cRuns).name, '/func/*bold.nii.gz']); % name of functional file
        func_path = [subject_data_path, subject_name, '/', subjectruns(cRuns).name, '/func/', func_file.name];  % path to functional file
        
        
% %         cur_header = load_untouch_header_only(func_path);
% %         nvols = cur_header.dime.dim(5); % the 5th column of the dim field of the dime field is where the number of volumes is
% %         critical_time = 1.448622*nvols; % important to get this value before convering nvols from double to string
% %         
        
        %% getting bfsl info
        
%         bfsl_dir = dir('/Users/michaelgiffin/Dropbox/UG_fMRI_pilot_data/ToProcess/sub-003/run-1/bfsl/*bfsl');
        
        bfsl_dir = dir(['/exports/fsw/mrgiffin/UG/ToProcess/' subject_name, '/', subjectruns(cRuns).name, '/bfsl/*bfsl']);
        
        EV_path = cell(length(bfsl_names), 1);
        for nameii = 1:length(bfsl_names)
            for dirii = 1:length(bfsl_dir)
                if strcmp(bfsl_dir(dirii).name(1:length(bfsl_names{nameii})), bfsl_names{nameii})
                    EV_path{nameii} = ['/exports/fsw/mrgiffin/UG/ToProcess/' subject_name, '/', subjectruns(cRuns).name, '/bfsl/', bfsl_dir(dirii).name];
                end
            end
        end
        
% %         
% %         EV1_path = ['/exports/fsw/mrgiffin/OT/expected_modeling/' subject_name, '/', subjectruns(cRuns).name, '/', bfsl_names{1}];
% %         EV2_path = ['/exports/fsw/mrgiffin/OT/expected_modeling/' subject_name, '/', subjectruns(cRuns).name, '/', bfsl_names{2}];
% %         EV3_path = ['/exports/fsw/mrgiffin/OT/expected_modeling/' subject_name, '/', subjectruns(cRuns).name, '/', bfsl_names{3}];
% %         EV4_path = ['/exports/fsw/mrgiffin/OT/expected_modeling/' subject_name, '/', subjectruns(cRuns).name, '/', bfsl_names{4}];
% %         EV5_path = ['/exports/fsw/mrgiffin/OT/expected_modeling/' subject_name, '/', subjectruns(cRuns).name, '/', bfsl_names{5}];
% %         EV6_path = ['/exports/fsw/mrgiffin/OT/expected_modeling/' subject_name, '/', subjectruns(cRuns).name, '/', bfsl_names{6}];
% %         
% %         
        %% Amending the fsf
        FileID = fopen('/exports/fsw/mrgiffin/UG/QD/Lev1_QD_template.fsf', 'r'); % this opens up the template file to be amended
        old_design = textscan(FileID, '%s', 'Delimiter', '\n');
        fclose(FileID);
        old_design  = old_design{1}; % now I can call a specific line and it is of class character instead of cell
        
% %         nvols = num2str(nvols); % must convert double to string to use strrep for fsf file
        
        to_be_replaced = {'__OUTPUT_DIR__',  '__FUNC_PATH__', '__T1_PATH__', '__EV_1__', '__EV_2__', '__EV_3__', '__EV_4__', '__EV_5__', '__EV_6__'};
        to_replace = {output_dir, func_path, anat_path, EV_path{1}, EV_path{2}, EV_path{3}, EV_path{4}, EV_path{5}, EV_path{6}};
        
        for ii = 1:length(to_be_replaced)
            old_design = strrep(old_design, to_be_replaced{ii}, to_replace{ii});
        end
        
        % the mkdir line is commented out because I already made the
        % subject directories with bfsl_weighter
        %             mkdir(['/Users/michaelgiffin/PhD/OT/expected_modeling/' subject_name, '/', subjectruns(cRuns).name]);
        %             mkdir(['/Volumes/My Passport for Mac/expected_modeling/' subject_name, '/', subjectruns(cRuns).name]);
        %             fid = fopen(sprintf('/Volumes/My Passport for Mac/expected_modeling/%s/%s/Lev1_template.fsf', subject_name, subjectruns(cRuns).name), 'w');
        
        fid = fopen(['/exports/fsw/mrgiffin/UG/QD/', subject_name, filesep, subjectruns(cRuns).name, filesep, output_path_name, '.fsf'], 'w');
        for r = 1:size(old_design,1)
            fprintf(fid, '%s\n', old_design{r});
        end
        fclose(fid);
        
        %% save bash script
        %----------------------------------------------------
        % here instead of running the actual feat, I'm going to save
        % all the feat commands in a txt file that can be submitted to
        % the cluster
        %----------------------------------------------------
        
        bash_cell{counter}  = sprintf('feat /exports/fsw/mrgiffin/UG/QD/%s/%s/%s.fsf\n', subject_name, subjectruns(cRuns).name, output_path_name);
        
        

    end
end


% writing the entire bash script to a file
fid = fopen(sprintf('/exports/fsw/mrgiffin/UG/ToProcess/scripts/bash/%s.sh', output_path_name), 'w');
for r = 1:length(bash_cell)
    fprintf(fid, '%s\n', bash_cell{r});
end
fclose(fid);

