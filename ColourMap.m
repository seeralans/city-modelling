function [] = ColourMap(WantedVariable)
% edit
if length(WantedVariable) ~= 3485
    error('Input vector should contain 3485 values')
end

load Coords
num = 3485;
for i = 1:num
    
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

    a = Coords{i}(:,1);
    b = Coords{i}(:,2);

    patch(a,b,[(WantedVariable(i)-MaxDat)/(MinDat-MaxDat) (WantedVariable(i)-MaxDat)/(MinDat-MaxDat) (WantedVariable(i)-MaxDat)/(MinDat-MaxDat)])%(WantedVariable(i)-MinDat)/(MaxDat-MinDat)(WantedVariable(i)-MaxDat)/(MinDat-MaxDat)
    
end