% ============================================
% script to calculate area difference
% written by: J. Andreasen
% Version 1
% date: 17 Apr 2019
% ============================================

% module A: User define input variables
A=dlmread('ronne_area1.prn'); %read in area change datasets from ice shelf 
x=A(:,1); %define x column 
y=A(:,2); %define y column 

%define color map to coincide with QGIS calving front colors
cc= [.769 .235 .224; .969 .545 .055; .969 .878 .055; .275 .824 .035; .035 .824 .733; .035 .533 1; .09 .035 .824; .471 .133 .91; .886 .133 .91; .976 .388 .714; 1 .89 .953]; %define color map to coincide with QGIS calving front colors;
colormap(cc);

fig=figure; %define figure

% module B: Plot area change difference against each year
set (gca, 'fontsize', 16,'linewidth', 1) %set the current bar plot axis to a fontsize of 14 and lindwidth of 1 
xlabel('Year','FontSize',16); %x-axis label and fontsize
ylabel('Ice Shelf Area (km^2)', 'FontSize',16); %y-axis label and fontsize
title('Ronne Ice Shelf Area Change 2009-2019'); %create a graph title

%for the length of the x (year) column 
for i=1:length(x)
    hold on %retain plots in the current axes so that new plots added to the axes do not delete existing plots 
    plot(x(i,1), y(i,1),'*','MarkerSize',10,'color',cc(i,:),'LineWidth', 10); %plot the x (year) vs. y (area) axes with a markersize of 10 and colors that coincide with the color map
    drawnow %draw plot
    xlim([2008 2020]); %set the year range on the x-axis 
    ylim([333000 350000]); %set the area range on the y-axis
    frame = getframe(fig); %define each additional year as a frame
    im{i} = frame2im(frame); %create images for each individual year frame
end

% module C: create and save gif
for i=1:length(x) %for the length of the x (year) column 
    subplot(3,4,i) %creates a 3 by 4 plot of images for gif 
    imshow(im{i}); %displays the im{i} image
end

filename = 'ronne_areachange.gif'; %specify the output file name

%for the length of the x (year) column 
for i = 1:length(x) %compile images in 3x4 plot to create a continuous gif loop 
   [A,map] = rgb2ind(im{i},256); %convert the RGB image to an indexed image A with the associated colormap "map" and 256 quantized colors for minimum variance quantization (constrain the input)
    if i == 1 
       imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1); %establish gif loop and delay time between each image
    else
       imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1); %establish append command to retain gif loop and delay time
    end
end

% ============================================