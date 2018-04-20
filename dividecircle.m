function dividecircle(xorig,yorig,r,number_of_equal_splits)

x = ones(number_of_equal_splits,1);
y = ones(number_of_equal_splits,1);
hold on
angle = 360/number_of_equal_splits;

for i = 1:number_of_equal_splits
    x(i,1) = xorig + r*cosd(angle*i);
    y(i,1)= yorig+ r*sind(angle*i);
end 
%adds angle to circle  
load('self_other_values.mat');
for i = 2:number_of_equal_splits+1
     textString = sprintf('%.1f°', degrees(i,1));
     text(x(i-1,1)-0.5, y(i-1,1)+0.9, textString, 'FontSize', 10);
 end
%%
for i = 1:2:number_of_equal_splits
    plot([xorig, x(i,1)],[yorig, y(i,1)],'color','red');
end

end
