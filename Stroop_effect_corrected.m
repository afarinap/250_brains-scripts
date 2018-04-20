% alllogs is our dataframe (matrices)

All_logs = xlsread('All_Logs_noheader.xlsx');
% All logs
% column 1 = subids
% column 2 = Time
% column 3 = Event Code
% column 4 = RT
% column 5 = Correct
% column 6 = Congruent 

All_logs_test = All_logs;
cong_rows    = find(All_logs(:,6) == 1);             % column 6 is congruent
incong_rows = find(All_logs(:,6) == 0);             % column 6 is congruent
all_subs = unique(All_logs(:, 1));

cong_mean_test    = NaN(length(all_subs), 2);
incong_mean_test  = NaN(length(all_subs), 2);
for ids = 1:length(all_subs)
    subrows      = find(All_logs(:,1) == all_subs(ids)); % column 1 is sub_ID
    
%     cong_count   = 0;
%     incong_count = 0;
%     RT_incong    = [];
%     RT_cong      = [];

    cong_count_test   = 0;
    incong_count_test = 0;
   
    RT_incong_test    = [];
    RT_cong_test      = [];
    
   % exclude trials that are >2.5 sds from average RT of that participant
 
    RT_outliers = find(All_logs(subrows,4) >= 2.5*std((All_logs(subrows,4)))); % find outliers for each participant
    All_logs_test([RT_outliers],4)=NaN; %remove outliers for each participant

    for ii = subrows'
        if All_logs_test(ii, 6) == 1
            cong_count_test          = cong_count_test + 1;
            RT_cong_test(cong_count_test) = All_logs_test(ii, 4);
        elseif All_logs_test(ii, 6) == 0
            incong_count_test          = incong_count_test + 1;
            RT_incong_test(incong_count_test) = All_logs_test(ii, 4);
        end 
    end
    
    cong_mean_test(ids, 1)   = mean(RT_cong_test, 'omitnan'); %dont take into account NaNs
    
    incong_mean_test(ids, 1) = mean(RT_incong_test,'omitnan');
    
    cong_mean_test(ids, 2)   = all_subs(ids); % add subject IDs
    incong_mean_test(ids, 2) = all_subs(ids);
    
    overall_mean_RT_test(ids,1) = (cong_mean_test(ids,1)+ incong_mean_test(ids,1)/2);
    
end




%% CHECK TTEST WITH NORMALIZED VALUES -- RESPONSE TIMES
[H P] = ttest2(cong_mean_test(:, 1), incong_mean_test(:, 1), 'tail', 'left');
% H = 1 rejects the null that the means are the same
% mean(cong_mean(:, 1))
% mean(incong_mean(:, 1))


% using mean RT to calculate normalized stroop effect, excluding trial
% outliers
stroop_value(:, 1) = ((incong_mean_test(:, 1) - cong_mean_test(:, 1))./overall_mean_RT_test(:)); 
stroop_value(:, 2) = incong_mean_test(:, 2); %subids


%% Stroop Effect figure 
cong_mean_test2 = cong_mean_test((cong_mean_test(:,1)>0), :); % to remove zero
incong_mean_test2 = incong_mean_test((incong_mean_test(:,1)>0), :);
figure

y = [mean(cong_mean_test2(:, 1)), mean(incong_mean_test2(:, 1))];
hbar = bar(y);
ylim([0, 350]);
title('Stroop Effect');
xlabels = {'Mean RT congruent trials', 'Mean RT incongruent trials'};
set(gca, 'xtick',1:4,'xticklabel', xlabels); 

hold on
p=line([1,2],[330,330], 'color', 'k');
hold off
text(1.5,330,'***','backgroundcolor','w','horizontalalignment','center','fontsize',15)


% % plot stroop effect of all partcipants
% stroop_value(:,3) = ones;
% figure
% scatter(stroop_value(:,3),stroop_value(:,1)); %plots all on same line
% %set(gca,'xtick',1, 'xticklabel','Subjects');
% title('Stroop Effect');
% 
% Avg_stroopeffect = mean(stroop_value(:,1),'omitnan');

%% PLOT average RT for cong and incongruent with mean RT for each and line on top showing significance
ste = @(x) (std(x)/sqrt(length(x)));
% cong_mean_test(cong_mean_test(:, 1)==0) = [];

close all
figure
hold on
y = [mean(cong_mean_test(:, 1)), mean(incong_mean_test(:, 1))];
yerr = [ste(cong_mean_test(:, 1)), ste(incong_mean_test(:, 1))];
plot([1,2], [cong_mean_test(:, 1), incong_mean_test(:, 1)], 'bo')

errorbar([1,2],y,yerr, 'o');
%ylim([0, 350]);
xlim([0, 4]);

title('Stroop Effect');
xlabels = {'RT congruent trials', 'RT incongruent trials'};
set(gca, 'xtick',1:4,'xticklabel', xlabels); 


hold on
p=line([1,2],[330,330], 'color', 'k');
hold off
text(1.5,330,'***','backgroundcolor','w','horizontalalignment','center','fontsize',15)

%% SVO part
svo = xlsread('SVO.xlsx');
% column 1 is SubiD
% column 2 is SVO
% column 3 is Wself
% column 4 is Wother
svo = sortrows(svo);


svo_stroop = NaN(length(stroop_value), 5);

for ii = 1:length(svo_stroop)
    svo_stroop(ii, 1:2) = stroop_value(ii, 2:-1:1); % subID and stroop effect based on means
    tmp                 = find(svo(:, 1) == svo_stroop(ii, 1));
    if length(tmp) == 1
        svo_stroop(ii,3)   = svo(tmp, 2);
        svo_stroop(ii,4)   = svo(tmp,3);
        svo_stroop(ii,5)   = svo(tmp,4);
    end
end

svo_stroop(any(isnan(svo_stroop), 2), :) = [];
% svo_stroop
% column 1 is subID
% column 2 is corrected stroop effect ((mean RT cong - mean RT incong)/avg RT)
% column 3 is SVO
% column 4 is Wself
% column 5 is Wother

% FROM add_neural_correlates.m
%column 9 is TPJ inc-cong
%column 10 is lDLPFC inc-cong
%column 11 is rDLPFC inc-cong
%column 12 is ACC inc-cong


%% count number of correct responses
% all_subs = unique(All_logs(:, 1));
% stroop_cor = NaN(length(all_subs), 2);
% for ii = 1:length(all_subs)
%     
%     tmp                 = find(All_logs(:, 1) == all_subs(ii));
%     cor_count = 0;
%     
%     for kk = tmp'
%         if All_logs(kk,5) == 1 && All_logs(kk,3) == 1 || All_logs(kk,5) == 1 &&  All_logs(kk,3) == 2
%             cor_count = cor_count + 1;
%         end
%     end
%     
%     stroop_cor(ii, 1) = all_subs(ii);
%     stroop_cor(ii, 2) = cor_count;
%     
% end

%% count number of correct congruent/incongruent responses
all_subs = unique(All_logs_test(:, 1));
stroop_cor = NaN(length(all_subs), 3);
for ii = 1:length(all_subs)
    
    tmp                 = find(All_logs_test(:, 1) == all_subs(ii));
    cor_cong_count = 0;
    cor_incong_count = 0;
    for kk = tmp'
        if All_logs_test(kk,5) == 1 && All_logs_test(kk,3) == 1 && All_logs_test(kk,6) == 1 ...
                || All_logs_test(kk,5) == 1 &&  All_logs_test(kk,3) == 2 && All_logs_test(kk,6) == 1
            cor_cong_count = cor_cong_count + 1;
        elseif All_logs_test(kk,5) == 1 && All_logs_test(kk,3) == 1 && All_logs_test(kk,6) == 0 ...
                || All_logs_test(kk,5) == 1 &&  All_logs_test(kk,3) == 2 && All_logs_test(kk,6) == 0
            cor_incong_count = cor_incong_count + 1;
        end
    end
    
    stroop_cor(ii, 1) = all_subs(ii);
    stroop_cor(ii, 2) = cor_cong_count;
    stroop_cor(ii, 3) = cor_incong_count;
    stroop_cor(ii, 4) = cor_cong_count + cor_incong_count; 




end

% ttest to see whether stroop effect also using accuracy 
% exclude those with > 2.5 SD from average number of total errors
Accuracy_outliers = find(stroop_cor(:,4) <= 2.5*std(stroop_cor(:,4)));
stroop_cor_ttest = stroop_cor;
stroop_cor_ttest([Accuracy_outliers],2:4) = nan;




 
[H2 P2] = ttest2(stroop_cor_ttest(:, 3),stroop_cor_ttest(:,4), 'tail', 'right'); %we expect more correct during congruent than incongruent trials
% H = 1 rejects the null that the means are the same



%% SVO part 2 - adding the correct responses ACCURACY 
% column 6 of svo_stroop is percent of correct congruent responses
% column 7 of svo_stroop is percent of correct incongruent responses
% column 8 of svo_stroop is difference bw # correct congruent and correct incongruent responses

svo_stroop(:, 6) = NaN(length(svo_stroop), 1);
svo_stroop(:, 7) = NaN(length(svo_stroop), 1);
svo_stroop(:,8) = NaN(length(svo_stroop),1);

for ii = 1:length(svo_stroop)
    tmp                 = find(svo_stroop(ii, 1) == stroop_cor(:, 1));
    if length(tmp) == 1 %make sure there is only one subID
        svo_stroop(ii,6)   = (stroop_cor(tmp,2)/48)*100; % since 48 is maximum correct responses
        svo_stroop(ii,7)   = (stroop_cor(tmp,3)/48)*100;
        svo_stroop(ii,8)   = svo_stroop(ii,6) - svo_stroop(ii,7);
    end
end


%% histograms of Wself and Wother distributions
% histogram((svo_stroop(:, 2)))
% histogram((svo_stroop(:, 3)))
figure
histogram((svo_stroop(:, 4)))
title('Distribution of Weight to Self');
xlim([-0.5 0.5]);
figure
histogram((svo_stroop(:, 5)))
title('Distribution of Weight to Other');
xlim([-0.5 0.5]);

%% scatterplots
close all
figure
hold on
h1 = scatter(svo_stroop(:,2),svo_stroop(:, 4), 50, 'b', 'filled');
ylabel('Weight');
xlabel('Stroop effect (in ms)');
title('Stroop effect and Self-Other Weights');
ylim([-0.5 0.5]);
% h2= lsline;
% set(h2,'color','b');
% set(get(get(h1, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off')
% xlim([0 160])
% legend({'Self Weight'});

h3 = scatter(svo_stroop(:,2),svo_stroop(:, 5),50, 'rd');

%ylabel('Weight');
%xlabel('Stroop effect (in ms)');
%title('Stroop effect and Other Weight');
%ylim([-0.5 0.5]);
% h4 = lsline;
% set(h4,'color','r');
% set(get(get(h2, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off')

legend([h1 h3], {'Self Weight', 'Other Weight'});
% h = lsline;
% set(h(1), 'color', 'b')
% 
% h = lsline;
% set(h(2), 'color', 'k')

hold off

%% scatterplots of SVO and brain areas
figure
hold on
h1 = scatter(svo_stroop(:,2),svo_stroop(:, 4), 50, 'b', 'filled');


%% here the test, was it worth it?
[RHO,PVAL] = corr(svo_stroop(:, 2), svo_stroop(:, 4), 'type', 'pearson')
[RHO,PVAL] = corr(svo_stroop(:, 2), svo_stroop(:, 5), 'type', 'pearson')
% stroop effect using differences in correct responses in cong vs incong trials
[RHO,PVAL] = corr(svo_stroop(:, 8), svo_stroop(:, 4), 'type', 'pearson') 
[RHO,PVAL] = corr(svo_stroop(:, 8), svo_stroop(:, 5), 'type', 'pearson') 

[RHO,PVAL] = corr(svo_stroop(:, 4), svo_stroop(:, 6), 'type', 'pearson')
[RHO,PVAL] = corr(svo_stroop(:, 5), svo_stroop(:, 6), 'type', 'pearson')


[beta, stats] = robustfit(svo_stroop(:, 2), svo_stroop(:, 4));
[beta, stats] = robustfit(svo_stroop(:, 2), svo_stroop(:, 5));


%% convert to Dataset
Behavioral_results = mat2dataset(svo_stroop,'VarNames',{'Subject_ID','StroopEffect','SVO','Wself','Wother','Correct Congruent Responses', ...
    'Correct Incongruent Responses','CongruentvsIncongruentResponses'});
export(Behavioral_results);
% %%
% model1 = stepwiselm(Behavioral_results,'StroopEffect~1+Wself+Wother+Wself*Wother','ResponseVar','StroopEffect','PredictorVars',...
%     {'Wself','Wother'});
% 
% model2 = stepwiseglm(Behavioral_results,'StroopEffect~1+Wself+Wother+Wself*Wother','ResponseVar','StroopEffect','PredictorVars',...
%     {'Wself','Wother'});
% 
% % using differences in number of correct responses as stroop effect
% model3 = stepwiseglm(Behavioral_results,'CongruentvsIncongruentResponses~1+Wself+Wother+Wself*Wother','ResponseVar',...
%     'CongruentvsIncongruentResponses','PredictorVars',{'Wself','Wother'});
