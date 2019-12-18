% ============================================
% script to create summary table for ice shelves
% written by: J. Andreasen
% Version 1
% date: 18 Apr 2019
% ============================================

% module A: User define input variables
Larsc=dlmread('larsc_area1.prn'); %read in area change datasets from ice shelf
Ronne=dlmread('ronne_area1.prn'); 
Filchner=dlmread('filch_area1.prn'); 
Brunt=dlmread('brunt_area1.prn'); 
Amery=dlmread('amery_area1.prn'); 
RossEast=dlmread('rosse_area1.prn'); 
RossWest=dlmread('rossw_area1.prn'); 
Thwaites=dlmread('thwaites_area1.prn'); 
PineIsland=dlmread('pinei_area1.prn'); 

%define x (year) and y (area) values for each ice shelf dataset
Lx=Larsc(:,1); Ly=Larsc(:,2); %Larsen C
Rox=Ronne(:,1); Roy=Ronne(:,2); %Ronne 
Fx=Filchner(:,1); Fy=Filchner(:,2); %Filchner 
Bx=Brunt(:,1); By=Brunt(:,2); %Brunt 
Ax=Amery(:,1); Ay=Amery(:,2); %Amery
Rex=RossEast(:,1); Rey=RossEast(:,2); %Ross East
Rwx=RossWest(:,1); Rwy=RossWest(:,2); %Ross West
Tx=Thwaites(:,1); Ty=Thwaites(:,2); %Thwaites
Px=PineIsland(:,1); Py=PineIsland(:,2); %Pine Island

%define z as the modified year column without the first year and q as the
%absolute values of the difference in area change to find the max value
Lz=Larsc(1:10,1); Lq=abs(diff(Ly)); %Larsen C
Roz=Ronne(1:10,1); Roq=abs(diff(Roy)); %Ronne 
Fz=Filchner(1:10,1); Fq=abs(diff(Fy)); %Filchner
Bz=Brunt(1:10,1); Bq=abs(diff(By)); %Brunt
Az=Amery(1:10,1); Aq=abs(diff(Ay)); %Amery
Rez=RossEast(1:10,1); Req=abs(diff(Rey)); %Ross East
Rwz=RossWest(1:10,1); Rwq=abs(diff(Rwy)); %Ross West
Tz=Thwaites(1:10,1); Tq=abs(diff(Ty)); %Thwaites
Pz=PineIsland(1:10,1); Pq=abs(diff(Py)); %Pine Island

%define MOD as a new table with the yearly area difference as the y value and its recorded years as the x values  
MODL= [Lz Lq]; MODRo= [Roz Roq]; MODF= [Fz Fq]; MODB= [Bz Bq]; MODA= [Az Aq]; MODRe= [Rez Req]; MODRw= [Rwz Rwq]; MODT= [Tz Tq]; MODP= [Pz Pq];

%Define the columns for each table column
IceShelf= ["LarsenC";"Ronne";"Filchner";"Brunt";"Amery";"RossEast";"RossWest";"Thwaites"; "PineIsland"];
%First (minimum) date recorded 
FirstDate= [min(Lx); min(Rox); min(Fx); min(Bx); min(Ax); min(Rex); min(Rwx); min(Tx); min(Px)];
%Last (maximum) date recorded
LastDate= [max(Lx); max(Rox); max(Fx); max(Bx); max(Ax); max(Rex); max(Rwx); max(Tx); max(Px)]; 
%First area recorded
FirstArea= [Ly(1); Roy(1); Fy(1); By(1); Ay(1); Rey(1); Rwy(1); Ty(1); Py(1)]; 
%Last area recorded
LastArea= [Ly(end); Roy(end); Fy(end); By(end); Ay(end); Rey(end); Rwy(end); Ty(end); Py(end)]; 
%Area change from 1st to last year recorded
FirstLastChange=round(LastArea(:,1)-FirstArea(:,1),1); 
%Area percent change from 1st year
PercentageChange=round((FirstLastChange(:,1)./FirstArea(:,1))*100,1); 

%Area difference per year
AreaDifference=[diff(Ly); diff(Roy); diff(Fy); diff(By); diff(Ay); diff(Rey); diff(Rwy); diff(Ty); diff(Py)]; 
%Average difference from 2009-2018/19
Average= [mean(diff(Ly)); mean(diff(Roy)); mean(diff(Fy)); mean(diff(By)); mean(diff(Ay)); mean(diff(Rey)); mean(diff(Rwy)); mean(diff(Ty)); mean(diff(Py))];
%Annual area rate of change 
RateofChange=round(Average(:,1),1);  
%Maximum values of area difference for each year 
Maxi=[max(abs(diff(Ly))); max(abs(diff(Roy))); max(abs(diff(Fy))); max(abs(diff(By))); max(abs(diff(Ay))); max(abs(diff(Rey))); max(abs(diff(Rwy))); max(abs(diff(Ty))); max(abs(diff(Py)))];
MaximumDistance=round(Maxi(:,1),1);
%Year that the maximum value of area difference occured for each ice shelf 
LInd= find(MODL(:,2) == max(Lq)); %Locate which row in the modified tables has the maximum difference value for Larsen C
LMaxY=MODL(LInd,1);%return value in second column for Larsen C
RoInd=find(MODRo(:,2)== max(Roq)); RoMaxY=MODRo(RoInd,1); %Ronne
FInd=find(MODF(:,2)== max(Fq)); FMaxY=MODF(FInd,1); %Filchner
BInd=find(MODB(:,2)== max(Bq)); BMaxY=MODB(BInd,1); %Brunt
AInd=find(MODA(:,2)== max(Aq)); AMaxY=MODA(AInd,1); %Amery
ReInd=find(MODRe(:,2)== max(Req)); ReMaxY=MODRe(ReInd,1); %Ross East
RwInd=find(MODRw(:,2)== max(Rwq)); RwMaxY=MODRw(RwInd,1); %Ross West
TInd=find(MODT(:,2)== max(Tq)); TMaxY=MODT(TInd,1); %Thwaites
PInd=find(MODP(:,2)== max(Pq)); PMaxY=MODP(PInd,1); %Pine Island
%Create matrix of years with maximum area difference for each ice shelf
MaximumYear=[LMaxY; RoMaxY; FMaxY; BMaxY; AMaxY; ReMaxY; RwMaxY; TMaxY; PMaxY];

format long 
%Create table combining all previously defined matrices
T= table(IceShelf,FirstDate, LastDate, FirstArea, LastArea, FirstLastChange, PercentageChange, RateofChange, MaximumDistance, MaximumYear)
T.Properties.VariableNames = {'Ice_Shelf' 'First_Date' 'Last_Date' 'First_Area_km2' 'Last_Area_km2' 'Change_between_First_and_Last_Date_km2' 'Percentage_Change' 'Rate_of_Change_km2_per_yr' 'Maximum_Distance_km2' 'Maximum_Distance_Year'}
% Get the table in string form. Source: MathWorks Support Team
TString = evalc('disp(T)');
% Use TeX Markup for bold formatting and underscores
TString = strrep(TString,'<strong>','\bf');
TString = strrep(TString,'</strong>','\rm');
TString = strrep(TString,'_',' '); %eliminate underscores 
TString = strrep(TString,'"',' '); %eliminate quotation marks
% Create a fixed-width font
FixedWidth = get(0,'FixedWidthFontName');
% Output the table with the annotation command
fig=annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
    'FontName',FixedWidth,'FontSize',13,'Units','Normalized','Position',[0 0 1 1]);
% Save the table as both a .png figure and an excel file for further reference and use
%uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,...
    %'RowName',T.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
saveas(fig, 'summarytable.png')
writetable(fig,'summarytable.xlsx');
