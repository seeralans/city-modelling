clear;

Cen = loadData; %Function just loads all the KS data files

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


[IDX C] = kmeans(allData(:,351:354),3);

for i = 1:3485
    
    a = Coords{i}(:,1);
    b = Coords{i}(:,2);
    if IDX(i) == 1
        col = 1;
    elseif IDX(i) == 2
        col = 0.5;
    else 
        col = 0;
    end
    patch(a,b,[col col col])
    %patch(a,b,[IDX(i)-1 IDX(i)-1 IDX(i)-1])
    %patch(a,b,[1-((WantedVariable(i)-MaxDat)/(MinDat-MaxDat)) 1-((WantedVariable(i)-MaxDat)/(MinDat-MaxDat)) 1-((WantedVariable(i)-MaxDat)/(MinDat-MaxDat))]);
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
%plot(CoordsCityCouncil(:,1),CoordsCityCouncil(:,2),'b','linewidth',3)