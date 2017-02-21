clear;

Cen = loadData(); %Function just loads all the KS data files

load Coords
load CoordsCityCouncil

num2 = 31; %Choose how many files to go through

cenData = [1:num2];

count = 1;
Tot=0;

for i = cenData
    Tot=Tot+size(Cen{i}.data,2);
end

allData = zeros(3485,Tot);

for i = cenData 
    for j = 1:size(Cen{i}.data,2)
        allData(:,count) = Cen{i}.data(:,j);
        count = count+1;
    end
end

WantedVariable = zeros(1,3485);

for i = 1:3485
    WantedVariable(i) = allData(i,354); %Change this index to desired variable
end
    
    
%     
MaxDat = max(WantedVariable); %Find highest value in data set
MinDat = min(WantedVariable); %Find lowest value in data set

%If there is massive spikes and the colour looks weird, uncomment these

%MaxDat = mean(WantedVariable)+2*std(WantedVariable);
%MinDat = mean(WantedVariable)-2*std(WantedVariable);

if MinDat < 0
    MinDat = 0;
end

WantedVariable(WantedVariable>MaxDat) = MaxDat;
WantedVariable(WantedVariable<MinDat) = MinDat;
for i = 1:3485
    
    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    patch(a,b,[1-((WantedVariable(i)-MaxDat)/(MinDat-MaxDat)) 1-((WantedVariable(i)-MaxDat)/(MinDat-MaxDat)) 1-((WantedVariable(i)-MaxDat)/(MinDat-MaxDat))]);
    %patch(a,b,[(WantedVariable(i)-MaxDat)/(MinDat-MaxDat) (WantedVariable(i)-MaxDat)/(MinDat-MaxDat) (WantedVariable(i)-MaxDat)/(MinDat-MaxDat)])%(WantedVariable(i)-MinDat)/(MaxDat-MinDat)(WantedVariable(i)-MaxDat)/(MinDat-MaxDat)
    hold on
end    
% IDX = 0;
% for i = 1:3485
%     
%     a = Coords{i}(:,1);
%     b = Coords{i}(:,2);
%     if WantedVariable(i) < 50
%         IDX = 1;
%     else
%         IDX = 0;
%     end
%     patch(a,b,[IDX IDX IDX])%(WantedVariable(i)-MinDat)/(MaxDat-MinDat)(WantedVariable(i)-MaxDat)/(MinDat-MaxDat)
%     hold on
% end  

%Uncomment this to plot bristol city council border
%plot(Coords2(:,1),Coords2(:,2),'b','linewidth',3)