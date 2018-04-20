function [FinalTable] = ReadLogTest(filename)

Allfiles = dir('*.log'); 
PathName = '/Users/andreafarina/Desktop/InternshipLeiden/250 Brains/piFiles'; 
N = {Allfiles.name};
logFile = strings(203,1);
FileName = ones(203,1);

fileID = ones(203,1);

for j = 1:203 
    
    logFile(j) = fullfile(PathName,N{j}); 
end
for j = 1:203
    fileID(j) = fopen(logFile(j));
end

for j = 1:203
    participant.data{j} = textscan(fileID(j),'%s %d %s %d %d %*d %*d %*d %*d %*d %*d %*s %*d','headerlines',4);
    fclose(fileID(j));
end
 


%%
for j = 1:203
    LogTimes.name{j} = num2str(['LogTimes_',num2str(j)]);
    LogSummary.name{j} = num2str(['LogSummary_',num2str(j)]);
end

Data_length = zeros(1,203);

LogTimes.SubID = [];
LogTimes.FemaleCongrPic = [];
LogTimes.FemaleIncongrPic = [];
LogTimes.FemaleResp = [];
LogTimes.MaleResp = [];
LogTimes.MaleCongrPic = [];
LogTimes.MaleIncongrPic = [];
LogSummary.Correct = [];
LogSummary.Error = [];
LogSummary.RT_Female = [];
LogSummary.RT_Male = [];
LogSummary.SigDiff = [];
LogSummary.SubID = [];
 % creates the structure with no values 

for j = 1:203
     Data_length(j) = length(participant.data{1,j}{1});
end
 
count_FemaleCongrPic = zeros(1,203);
count_FemaleIncongrPic = zeros(1,203);

count_MaleCongrPic = zeros(1,203);
count_MaleIncongrPic = zeros(1,203);

count_FemaleResp = zeros(1,203);
count_MaleResp = zeros(1,203);

%% remove everything before trial 14
for j = 1:203
    for ind = 1:Data_length(j)
        if participant.data{1,j}{2}(ind)<14
            participant.data{1,j}{4}(ind) =0; %this way we don't count female and male presses before trials that count
        end
    end
end

%%
%show times of Female Congruent images
for j = 1:203
    for ind = 1:Data_length(j)
        if 100<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<113
            count_FemaleCongrPic(j) = count_FemaleCongrPic(j) + 1;
            LogTimes.FemaleCongrPic(j,count_FemaleCongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 200<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<213
            count_FemaleCongrPic(j) = count_FemaleCongrPic(j) + 1;
            LogTimes.FemaleCongrPic(j,count_FemaleCongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 300<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<313
            count_FemaleCongrPic(j) = count_FemaleCongrPic(j) + 1;
            LogTimes.FemaleCongrPic(j,count_FemaleCongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 400<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<413
            count_FemaleCongrPic(j) = count_FemaleCongrPic(j) + 1;
            LogTimes.FemaleCongrPic(j,count_FemaleCongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        end
    end
end
    


%% show times of Female text/Male face Incongruent images
for j = 1:203
    for ind = 1:Data_length(j)
        if 112<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<126
            count_FemaleIncongrPic(j) = count_FemaleIncongrPic(j) + 1;
            LogTimes.FemaleIncongrPic(j,count_FemaleIncongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 212<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<226
            count_FemaleIncongrPic(j) = count_FemaleIncongrPic(j) + 1;
            LogTimes.FemaleIncongrPic(j,count_FemaleIncongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 312<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<326
            count_FemaleIncongrPic(j) = count_FemaleIncongrPic(j) + 1;
            LogTimes.FemaleIncongrPic(j,count_FemaleIncongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 412<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<426
            count_FemaleIncongrPic(j) = count_FemaleIncongrPic(j) + 1;
            LogTimes.FemaleIncongrPic(j,count_FemaleIncongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        end
    end
end

%% show times of Male Congruent images
for j = 1:203
   for ind = 1:Data_length(j)
        if 512<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<526
            count_MaleCongrPic(j) = count_MaleCongrPic(j) + 1;
            LogTimes.MaleCongrPic(j,count_MaleCongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 612<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<626
            count_MaleCongrPic(j) = count_MaleCongrPic(j) + 1;
            LogTimes.MaleCongrPic(j,count_MaleCongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 712<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<726
            count_MaleCongrPic(j) = count_MaleCongrPic(j) + 1;
            LogTimes.MaleCongrPic(j,count_MaleCongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 812<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<826
            count_MaleCongrPic(j) = count_MaleCongrPic(j) + 1;
            LogTimes.MaleCongrPic(j,count_MaleCongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        end
    end
end 
%% show times of Male text/female face Incongruent images
for j = 1:203 
     for ind = 1:Data_length(j)
        if 500<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<513
            count_MaleIncongrPic(j) = count_MaleIncongrPic(j) + 1;
            LogTimes.MaleIncongrPic(j,count_MaleIncongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 600<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<613
            count_MaleIncongrPic(j) = count_MaleIncongrPic(j) + 1;
            LogTimes.MaleIncongrPic(j,count_MaleIncongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 700<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<713
            count_MaleIncongrPic(j) = count_MaleIncongrPic(j) + 1;
            LogTimes.MaleIncongrPic(j,count_MaleIncongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        elseif 800<participant.data{1,j}{4}(ind) && participant.data{1,j}{4}(ind)<813
            count_MaleIncongrPic(j) = count_MaleIncongrPic(j) + 1;
            LogTimes.MaleIncongrPic(j,count_MaleIncongrPic(j)) = participant.data{1,j}{5}(ind)/10;
        end
    end
end

%% show times of responses female
for j = 1:203
     for ind = 1:Data_length(j)
        if participant.data{1,j}{4}(ind) == 2
            count_FemaleResp(j) = count_FemaleResp(j) + 1;
            LogTimes.FemaleResp(j,count_FemaleResp(j)) = participant.data{1,j}{5}(ind)/10;
        end
    end
end

%% show times of responses male
for j = 1:203
    for ind = 1:Data_length(j)
        if participant.data{1,j}{4}(ind) == 1
            count_MaleResp(j) = count_MaleResp(j) + 1;
            LogTimes.MaleResp(j,count_MaleResp(j)) = participant.data{1,j}{5}(ind)/10;
        end
    end
end

%% add subject IDs
for j = 1:203
    for ind = 1:Data_length(j)
        LogTimes.SubID{j} = erase(participant.data{1,j}{1}{ind},'pi0');
    end
end

for ind = 1:Data_length(203)
    LogTimes.SubID{203} = erase(participant.data{1,203}{1}{ind},'pp00');
end

for ind = 1:Data_length(94)
    LogTimes.SubID{94} = erase(participant.data{1,94}{1}{ind},'nl0');
end

for ind = 1:Data_length(202)
    LogTimes.SubID{202} = erase(participant.data{1,202}{1}{ind},'pi');
end

for j= 1:203
    for ind = 1:Data_length(j)
        LogTimes.SubID{j} = strip(LogTimes.SubID{j},'left','0');
    end
end
%% create a temporary matrix containing times (column 1) and event codes (column 2)
% 1 - Male response
% 2 - Female response
% 3 - FemaleCongrPic
% 4 - FemaleIncongrPic
% 5 - MaleCongrPic
% 6 - MaleIncongrPic

TempMatrix.name = [];
for j = 1:203
    TempMatrix.name{j} = num2str(['TempMatrix_',num2str(j)]);
end

for j = 1:203   
    TempMatrix.name{j} = [[transpose(LogTimes.MaleIncongrPic(j,:)), repmat(6,size(LogTimes.MaleIncongrPic,2),1)];...
        [transpose(LogTimes.FemaleIncongrPic(j,:)), repmat(4,size(LogTimes.FemaleIncongrPic,2),1)];...
        [transpose(LogTimes.MaleResp(j,:)),repmat(ones,size(LogTimes.MaleResp,2),1)];...
        [transpose(LogTimes.FemaleResp(j,:)), repmat(2,size(LogTimes.FemaleResp,2),1)];...
        [transpose(LogTimes.FemaleCongrPic(j,:)),repmat(3,size(LogTimes.FemaleCongrPic,2),1)];...
        [transpose(LogTimes.MaleCongrPic(j,:)), repmat(5,size(LogTimes.MaleCongrPic,2),1)]];
end

%sort by time 
TempMatrix.sorted = [];

for j = 1:203
    TempMatrix.sorted{j} = sortrows(TempMatrix.name{j});
end

%% delete extra responses, whenever the time is 0
for j = 1:203
    for ind = 1:length(TempMatrix.sorted{j})
        if TempMatrix.sorted{j}(ind,1) == 0
            TempMatrix.sorted{j}(ind,2) = 0;
        end
    end
end

%% find FemaleResp and see if image was of female face

IsFemale = [];
CorrectFemaleCongr = [];
CorrectFemaleIncongr = [];
CorrectFemale = [];
RTFemale = [];

%set up IsFemale as structure
IsFemale{1} = find(TempMatrix.sorted{1}(:,2) == 2);

%fill in the rest of participants
for j = 1:203
    IsFemale{j} = find(TempMatrix.sorted{j}(:,2) == 2);
end

for j = 1:203
    for ind = 1:length(IsFemale{j})
        CorrectFemaleCongr{j}(ind) = TempMatrix.sorted{j}((IsFemale{j}(ind)-1),2) == 3;
        CorrectFemaleIncongr{j}(ind)= TempMatrix.sorted{j}(IsFemale{j}(ind)-1,2)== 6;
    end
end
%Set up CorrectFemale as structure
CorrectFemale{1} = sum(CorrectFemaleCongr{1}(:)) + sum(CorrectFemaleIncongr{1}(:));

%fill in rest of participants
for j = 1:203
    CorrectFemale{j} = sum(CorrectFemaleCongr{j}(:)) + sum(CorrectFemaleIncongr{j}(:));
end

%Reaction times in ms for all (correct and incorrect) female responses
for j = 1:203
    for ind = 1:length(IsFemale{j})
        RTFemale{j}(ind,1) =  TempMatrix.sorted{j}(IsFemale{j}(ind),1)-TempMatrix.sorted{j}(IsFemale{j}(ind)-1,1);
        % code 0 for incorrect RT and 1 for correct RT
        RTFemale{j}(ind,2) = CorrectFemaleCongr{j}(ind)+CorrectFemaleIncongr{j}(ind);
    end
end

% 
%% find MaleResp and see if image was of male face
IsMale = [];
CorrectMaleCongr = [];
CorrectMaleIncongr = [];
CorrectMale = [];
RTMale = [];

IsMale{1} = find(TempMatrix.sorted{1}(:,2) == 1);
for j = 1:203
    IsMale{j} = find(TempMatrix.sorted{j}(:,2) == 1);
end

for j = 1:203
    for ind = 1:length(IsMale{j})
        CorrectMaleCongr{j}(ind) = TempMatrix.sorted{j}((IsMale{j}(ind)-1),2) == 5;
        CorrectMaleIncongr{j}(ind)= TempMatrix.sorted{j}(IsMale{j}(ind)-1,2)== 4;
    end
end

CorrectMale{1} = sum(CorrectMaleCongr{1}(:)) + sum(CorrectMaleIncongr{1}(:));

for j = 1:203
    CorrectMale{j} = sum(CorrectMaleCongr{j}(:)) + sum(CorrectMaleIncongr{j}(:));
end

%Reaction times in ms for correct male responses

for j = 1:203
    for ind = 1:length(IsMale{j})
        RTMale{j}(ind,1) =  TempMatrix.sorted{j}(IsMale{j}(ind),1)-TempMatrix.sorted{j}(IsMale{j}(ind)-1,1);
        % code 0 for incorrect RT and 1 for correct RT
        RTMale{j}(ind,2) = CorrectMaleCongr{j}(ind)+CorrectMaleIncongr{j}(ind);
    end
end

%% FINAL TABLE
for j = 1:203
    PermMatrix{j}=[repmat(str2num(LogTimes.SubID{j}),length(TempMatrix.sorted{j}),1), TempMatrix.sorted{j}(:,1:2)];
end

PermMatrix{202} = [repmat(153,length(TempMatrix.sorted{202}),1), TempMatrix.sorted{202}(:,1:2)];

for j = 1:203
    maleresponses{j} = find(PermMatrix{j}(:,3) == 1);
end

% add response times 
for j = 1:5
    for ind = maleresponses{j}(1:end)
        PermMatrix{j}(ind,4) = RTMale{j}(find(ind),1);
        PermMatrix{j}(ind,5) = RTMale{j}(find(ind),2);
    end
end


for j = 7:203
    for ind = maleresponses{j}(1:end)
        PermMatrix{j}(ind,4) = RTMale{j}(find(ind),1);
        PermMatrix{j}(ind,5) = RTMale{j}(find(ind),2);
    end
end


for j = 1:203
    femaleresponses{j} = find(PermMatrix{j}(:,3)==2);
end

for j = 1:5
    for ind = femaleresponses{j}(1:end)
        PermMatrix{j}(ind,4) = RTFemale{j}(find(ind),1);
        PermMatrix{j}(ind,5) = RTFemale{j}(find(ind),2);        
    end
end

for j = 7:203
    for ind = femaleresponses{j}(1:end)
        PermMatrix{j}(ind,4) = RTFemale{j}(find(ind),1);
        PermMatrix{j}(ind,5) = RTFemale{j}(find(ind),2);        
    end
end
%%
%delete empty cells
for j = 1:203
    todelete{j} = find(PermMatrix{j}(:,2) == 0);
end

for j = 1:203
    PermMatrix{j}(1:todelete{j}(end),:) = [];    
end

%add congruent(1) or incongruent(0) label to column 6

for j = 1:203
    congruent{j}= sort([find(PermMatrix{j}(:,3) == 3); find(PermMatrix{j}(:,3)==5)]);
end

for j = 1:203
    for ind = congruent{j}(1:end)
        PermMatrix{j}(ind,6) = 1;
        PermMatrix{j}(ind+1,6) = 1; %makes it easy to see the response to a congruent trial
    end
end

%% add headers to matrices BETTER WAY??
header = {'SubID', 'Time','Event Code', 'RT', 'Correct', 'Congruent'};
test = cell2mat(PermMatrix');
FinalTable = [header; num2cell(test)];

%% make sure  CorrectFemale+CorrectMale is not greater than 96 (if it is, they double responded to an image)
% for j = 1 :203
%     TotalResp(j) = CorrectFemale{j}+ CorrectMale{j};
% end
% 
% for j = 1:203
%     a = find(TotalResp(j)>96)
% end

end 

%% to export data to excel
% test=cell2mat(FinalTable(2:end,:));
% xlswrite('PiLogs.xlsx',test);