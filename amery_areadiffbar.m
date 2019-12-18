% ============================================
% script to calculate area difference bar graph
% written by: J. Andreasen
% Version 1
% date: 17 Apr 2019
% ============================================

% module A: User define input variables
A=dlmread('amery_area1.prn'); %read in area change datasets from ice shelf
x=A(:,1); %define x column 
y=A(:,2); %define y column 
Z=A(1:10,1); %disregard last date in regards to area difference data
B=diff(y); %calculate difference in area change for each year

%define altered color map, without first date color, to coincide with QGIS calving front colors
cc2= [.969 .545 .055; .969 .878 .055; .275 .824 .035; .035 .824 .733; .035 .533 1; .09 .035 .824; .471 .133 .91; .886 .133 .91; .976 .388 .714; 1 .89 .953]; %define altered color map without first date color to coincide with QGIS calving front colors
colormap(cc2);

%associate each color in the color map with a different B value 
fHand= figure; %define the function handle as a figure
aHand=axes('parent',fHand); %define the axis handle
hold(aHand, 'on') %retain plots in the current axes so that new plots added to the axes do not delete existing plots

%for the length of the Z column (modified dates/years), associate each area difference value in column B with each color in the color map 
for i=1:length(Z)
     bar(Z(i,1), B(i,1), 'parent', aHand, 'facecolor', cc2(i,:)); %establish connection between B column and color map
end

% module B: Plot area change difference against each year
set (gca, 'fontsize', 16,'linewidth', 1); %set the current bar plot axis to a fontsize of 14 and lindwidth of 1 
xlabel('Year','FontSize',16); %x-axis label and fontsize
ylabel('Ice Shelf Area Difference (km^2)', 'FontSize',16); %y-axis label and fontsize

xlim([2008 2019]); %set the year range on the x-axis 
ylim([50 300]) %set the area difference range on the y-axis
title('Yearly Amery Ice Shelf Area Difference 2009-2019'); %create a graph title

% module C: save resulting figure
filename = 'area_diffbar.png' %define the filename
saveas(fHand,'area_diffbar.png') %save the bar graph figure under this name

% ============================================
