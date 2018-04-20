svo_stroop = xlsread('svo_stroop.xls');

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



close all
figure
hold on
h1 = scatter(svo_stroop(:,10),svo_stroop(:, 4), 50, 'b', 'filled');
ylabel('Weight');
xlabel('Incongruent>Congruent');
title('SVO and lDLPFC activity');
ylim([-0.5 0.5]);


h3 = scatter(svo_stroop(:,10),svo_stroop(:, 5),50, 'rd');


legend([h1 h3], {'Self Weight', 'Other Weight'});

hold off