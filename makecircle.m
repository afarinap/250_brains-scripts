
function makecircle = makecircle(x,y,r)

figure 
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
makecircle = plot(xunit, yunit,'color',[0 0 0]);

%loads question points
load('self_other_values.mat')
 grid off;
 

xlabel('Self Outcome'); % x-axis label
ylabel('Other Outcome'); % y-axis label


set (gca,'YLim',[0 35]);%y-axis limit
set(gca,'XLim',[0 30]); % x-axis limit
%set(gca,'Box','on');
th = title('Social Value Orientation');
titlepos = get(gca,'position'); %move title position
set(th,'Position',[15 33 0]);
set(gcf,'WindowStyle','normal');

%plot ([0 30],[15 15],'color',[0 0 0],'linestyle','--','marker','>','markerindices',2,...
 %'markersize',10,'MarkerFaceColor',[0 0 0]);

%plot ([15 15],[0 30],'color',[0 0 0],'linestyle','--','marker','^','markerindices',2,...
%'markersize',10,'MarkerFaceColor',[0 0 0]); 
%% 
%to get lines for degree divisions use i =2:2:24
%for i = 2:2:24
% to get lines for svo questions use i = 1:24
for i = 1:24
    plot([15,selfothervalues(i,1)],[15,selfothervalues(i,2)], 'Marker','o','Color','red', 'LineWidth',0.5)
 end
 linehandle = findobj(gcf,'type','line');
 set(linehandle,'Alignvertexcenters','on');
 set(linehandle([1:5,7:11,13:17,19:23]),'color','red');
 set(linehandle([6,12,18,24]),'color',[0 0 0],'linestyle','--');
set(linehandle(18),'color',[0 0 0],'linestyle','--','marker','>','markerindices',2,...
 'markersize',10,'MarkerFaceColor',[0 0 0]);
set(linehandle(24),'color',[0 0 0],'linestyle','--','marker','^','markerindices',2,...
 'markersize',10,'MarkerFaceColor',[0 0 0]);
% adds (x,y) coordinates to circle
 for i = 1:24     
     textString = sprintf('(%0.1f,%0.1f)', selfothervalues(i,1), selfothervalues(i,2));
     text(selfothervalues(i,1)-0.5, selfothervalues(i,2)+0.9, textString, 'FontSize', 12);
 end
%% 
%adds angle to circle

% for i = 1:24     
%      textString = sprintf('%.1f°', degrees(i,1));
%      text(selfothervalues(i,1)-0.5, selfothervalues(i,2)+0.9, textString, 'FontSize', 10);
%  end
%%

end



